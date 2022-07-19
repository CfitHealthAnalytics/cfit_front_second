import 'dart:async';
import 'dart:convert';

import 'package:cfit/data/modal/response/address_model.dart';
import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';
import 'package:cfit/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

final appKey = GlobalKey();

class LocationController extends GetxController implements GetxService {
  double lat = -8.0631925;
  double long = -34.8711269;
  String erro = '';
  late GoogleMapController _mapsController;

  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();

  LocationController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Position _position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Position _pickPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  bool _loading = false;
  String _address = '';
  String _pickAddress = '';
  //final List<Marker> _markers = <Marker>[];

  Set<Marker> markers = <Marker>{};

  int _addressTypeIndex = 0;
  final List<String> _addressTypeList = ['home', 'office', 'others'];
  bool _isLoading = false;
  bool _inZone = false;
  final int _zoneID = 0;
  bool _buttonDisabled = true;
  bool _changeAddress = true;
  GoogleMapController? _mapController;
  bool _updateAddAddressData = true;

  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  //List<Marker> get markers => _markers;
  List<String> get addressTypeList => _addressTypeList;
  int get addressTypeIndex => _addressTypeIndex;
  bool get inZone => _inZone;
  int get zoneID => _zoneID;
  bool get buttonDisabled => _buttonDisabled;
  GoogleMapController? get mapController => _mapController;

  String ChaveGoogleMaps = 'AIzaSyDRzX9zGqcnCDX98AcXyxGNvUHz8cCTGpQ';

  get mapsController => _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    //loadPostos();
  }

  /*
  loadPostos() {
    final postos = EventRepository().postos;

    for (var posto in postos) async {
      markers.add(
        Marker(
          markerId: MarkerId(posto.nome),
          position: LatLng(posto.latitude, posto.longitude),
          icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'images/posto.png',
          ),
          onTap: () => {
            showModalBottomSheet(
              context: appKey.currentState!.context,
              builder: (context) => EventDetails(posto: posto),
            )
          },
        ),
      );
    }
    //notifyListeners();
  }
  */

  setPosicao(double lat, double long) async {
    try {
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
    //notifyListeners();
  }

  Future<dynamic> fetchEndereco(String endereco) async {
    String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" +
        ChaveGoogleMaps +
        "&callback=initialize&libraries=drawing,places&v=3.49&address=" +
        endereco;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic dadosB = jsonDecode(response.body);
      setPosicao(dadosB['results'][0]['geometry']['location']['lat'],
          dadosB['results'][0]['geometry']['location']['lng']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchCoordenadas(double lat, double lng) async {
    String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" +
        ChaveGoogleMaps +
        "&latlng=" +
        lat.toString() +
        "," +
        lng.toString();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic dadosB = jsonDecode(response.body);
      setPosicao(dadosB['results'][0]['geometry']['location']['lat'],
          dadosB['results'][0]['geometry']['location']['lng']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<AddressModel> getCurrentLocation(bool fromAddress,
      {GoogleMapController? mapController,
      LatLng? defaultLatLng,
      bool notify = true}) async {
    _loading = true;
    if (notify) {
      update();
    }
    AddressModel _addressModel;
    Position _myPosition;
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _myPosition = newLocalData;
    } catch (e) {
      _myPosition = Position(
        latitude: defaultLatLng != null ? defaultLatLng.latitude : -8.0631925,
        longitude:
            defaultLatLng != null ? defaultLatLng.longitude : -34.8711269,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    }
    if (fromAddress) {
      _position = _myPosition;
    } else {
      _pickPosition = _myPosition;
    }
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(_myPosition.latitude, _myPosition.longitude),
          zoom: 17),
    ));
    String _addressFromGeocode = await getAddressFromGeocode(
        LatLng(_myPosition.latitude, _myPosition.longitude));
    fromAddress
        ? _address = _addressFromGeocode
        : _pickAddress = _addressFromGeocode;
    ZoneResponseModel _responseModel = await getZone(
        _myPosition.latitude.toString(),
        _myPosition.longitude.toString(),
        true);
    _buttonDisabled = !_responseModel.isSuccess;
    _addressModel = AddressModel(
      latitude: _myPosition.latitude.toString(),
      longitude: _myPosition.longitude.toString(),
      addressType: 'others',
      zoneId: _responseModel.isSuccess ? _responseModel.zoneIds[0] : 0,
      address: _addressFromGeocode,
    );
    _loading = false;
    update();
    return _addressModel;
  }

  Future<ZoneResponseModel> getZone(
      String lat, String long, bool markerLoad) async {
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    ZoneResponseModel _responseModel;

    /*
    Response response = await locationRepo.getZone(lat, long);
    if (response.statusCode == 200) {
      _inZone = true;
      _zoneID = int.parse(jsonDecode(response.body['zone_id'])[0].toString());
      List<int> _zoneIds = [];
      jsonDecode(response.body['zone_id']).forEach((zoneId) {
        _zoneIds.add(int.parse(zoneId.toString()));
      });
      _responseModel = ZoneResponseModel(true, '', _zoneIds);
    } else {
      _inZone = false;
      _responseModel = ZoneResponseModel(false, response.statusText??'', []);
    }
    */

    _responseModel = ZoneResponseModel(false, 'Teste Localização', []);

    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }
        ZoneResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            true);
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          String _addressFromGeocode = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _address = _addressFromGeocode
              : _pickAddress = _addressFromGeocode;
        } else {
          _changeAddress = true;
        }
      } catch (e) {}
      _loading = false;
      update();
    } else {
      _updateAddAddressData = true;
    }
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void _setZoneData(AddressModel address, bool fromSignUp, String route,
      bool canRoute, bool isDesktop) {
    Get.find<LocationController>()
        .getZone(address.latitude ?? '', address.longitude ?? '', false)
        .then((response) async {
      if (response.isSuccess) {
        address.zoneId = response.zoneIds[0];
        //autoNavigate(address, fromSignUp, route, canRoute, isD`esktop);
      } else {
        Get.back();
        showCustomSnackBar(response.message);
      }
    });
  }

  Future<AddressModel> setLocation(
      String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();

    LatLng _latLng = const LatLng(0, 0);

    /*
    Response response = await locationRepo.getPlaceDetails(placeID);
    if (response.statusCode == 200) {
      PlaceDetailsModel _placeDetails =
          PlaceDetailsModel.fromJson(response.body);
      if (_placeDetails.status == 'OK') {
        _latLng = LatLng(_placeDetails.result.geometry.location.lat,
            _placeDetails.result.geometry.location.lng);
      }
    }*/

    _pickPosition = Position(
      latitude: _latLng.latitude,
      longitude: _latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
    );

    _pickAddress = address;
    _changeAddress = false;

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _latLng, zoom: 17)));
    _loading = false;
    update();
    return AddressModel(
      latitude: _pickPosition.latitude.toString(),
      longitude: _pickPosition.longitude.toString(),
      addressType: 'others',
      address: _pickAddress,
    );
  }

  void disableButton() {
    _buttonDisabled = true;
    _inZone = true;
    update();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress;
    _updateAddAddressData = false;
    update();
  }

  void setUpdateAddress(AddressModel address) {
    _position = Position(
      latitude: double.parse(address.latitude ?? ''),
      longitude: double.parse(address.longitude ?? ''),
      timestamp: DateTime.now(),
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      floor: 1,
      accuracy: 1,
    );
    _address = address.address ?? '';
    _addressTypeIndex = _addressTypeList.indexOf(address.addressType ?? '');
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
  }

  void setMapController(GoogleMapController mapController) {
    getPosicao();
    _mapController = mapController;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    /*
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    String _address = 'Unknown Location Found';
    if (response.statusCode == 200 && response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      showCustomSnackBar(response.body['error_message'] ?? response.bodyString);
    }
    */

    return _address;
  }

  void setPlaceMark(String address) {
    _address = address;
  }

  void checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    } else if (permission == LocationPermission.deniedForever) {
      print('Solicitar Permissão');
      //Get.dialog(PermissionDialog());
    } else {
      onTap();
    }
  }

  AddressModel getUserAddress() {
    AddressModel _addressModel = AddressModel();
    /*
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {}*/
    return _addressModel;
  }
}

class ZoneResponseModel {
  final bool _isSuccess;
  final List<int> _zoneIds;
  final String _message;
  ZoneResponseModel(this._isSuccess, this._message, this._zoneIds);

  String get message => _message;
  List<int> get zoneIds => _zoneIds;
  bool get isSuccess => _isSuccess;
}

class ResponseModel {
  final bool _isSuccess;
  final String _message;
  ResponseModel(this._isSuccess, this._message);

  String get message => _message;
  bool get isSuccess => _isSuccess;
}
