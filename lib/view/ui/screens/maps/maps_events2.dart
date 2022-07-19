import 'dart:async';
import 'dart:ui';

import 'package:cfit/util/Images.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_add.dart';
import 'package:cfit/view/ui/screens/maps/location_controller.dart';
import 'package:cfit/view/ui/screens/widgets/events_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventsMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(17, 165, 153, 1);
    const primaryColorDark = Color.fromARGB(255, 38, 162, 151);
    const primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColorLight)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          alignLabelWithHint: true,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: const ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      title: 'CFIT',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  double lat = -8.0631925;
  double long = -34.8711269;

  final Position _position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
  );
  Position _pickPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
  );

  final bool _loading = false;
  final String _address = '';
  final String _pickAddress = '';
  final List<Marker> _markers = <Marker>[];
  final int _addressTypeIndex = 0;
  final List<String> _addressTypeList = ['home', 'office', 'others'];
  final bool _isLoading = false;
  final bool _inZone = false;
  final int _zoneID = 0;
  final bool _buttonDisabled = true;
  final bool _changeAddress = true;
  GoogleMapController? _mapController;
  final bool _updateAddAddressData = true;

  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  List<Marker> get markers => _markers;
  List<String> get addressTypeList => _addressTypeList;
  int get addressTypeIndex => _addressTypeIndex;
  bool get inZone => _inZone;
  int get zoneID => _zoneID;
  bool get buttonDisabled => _buttonDisabled;

  CameraPosition? _cameraPosition;
  final LatLng _latLng = const LatLng(-8.0631925, -34.8711269);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-8.0631925, -34.8711269),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  //-8.0631925,-34.8711269

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          children: [
            const EventsAppBar(),
            SizedBox(
              height: Get.height,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            locationController.lat, locationController.long),
                        zoom: 18,
                      ),
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      // myLocationEnabled: true,
                      onMapCreated: locationController.onMapCreated,
                      markers: locationController.markers,
                    ),
                    Center(
                        child: !locationController.loading
                            ? Image.asset(Images.pick_marker,
                                height: 50, width: 50)
                            : const CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Adicionar Evento'),
        icon: const Icon(Icons.event),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    print('adiciona');

    //print(_cameraPosition?.target.latitude);
    //print(_cameraPosition?.target.longitude);

    Get.find<EventsController>().setLocation(
      _cameraPosition?.target.latitude ?? lat,
      _cameraPosition?.target.longitude ?? long,
    );

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: EventsAdd(),
      ),
    );

    /*
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    */
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    try {
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
      /*
      ZoneResponseModel _responseModel = await getZone(
          position.target.latitude.toString(),
          position.target.longitude.toString(),
          true);
      _buttonDisabled = !_responseModel.isSuccess;
      */
      if (_changeAddress) {
        /*
        String _addressFromGeocode = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude));
        fromAddress
            ? _address = _addressFromGeocode
            : _pickAddress = _addressFromGeocode;

            */
      } else {
        //_changeAddress = true;
      }
    } catch (e) {}
  }

  Future<ZoneResponseModel> getZone(
      String lat, String long, bool markerLoad) async {
    if (markerLoad) {
      //_loading = true;
    } else {
      //_isLoading = true;
    }
    ZoneResponseModel _responseModel;
    /*
    Response response = await locationRepo.getZone(lat, long);
    if (response.statusCode == 200) {
      _zoneID = int.parse(jsonDecode(response.body['zone_id'])[0].toString());
      List<int> _zoneIds = [];
      jsonDecode(response.body['zone_id']).forEach((zoneId) {
        _zoneIds.add(int.parse(zoneId.toString()));
      });
      _responseModel = ZoneResponseModel(true, '', _zoneIds);
    } else {
      _inZone = false;
      _responseModel = ZoneResponseModel(false, response.statusText, []);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    */
    _responseModel = ZoneResponseModel(false, '', []);
    return _responseModel;
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
