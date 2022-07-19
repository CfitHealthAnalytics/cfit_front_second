import 'dart:async';
import 'dart:ui';

import 'package:cfit/constants.dart';
import 'package:cfit/util/Images.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_add.dart';
import 'package:cfit/view/ui/screens/maps/location_controller.dart';
import 'package:cfit/view/ui/screens/widgets/events_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventsMaps extends StatefulWidget {
  @override
  State<EventsMaps> createState() => MapSampleState();
}

class MapSampleState extends State<EventsMaps> {
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  final String _destinationAddress = '';
  String? _placeDistance;

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: GetBuilder<LocationController>(builder: (locationController) {
        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              // Map View

              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(locationController.lat, locationController.long),
                  zoom: 18,
                ),
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                myLocationEnabled: false,
                onMapCreated: locationController.onMapCreated,
                markers: locationController.markers,
              ),
              Center(
                child: !locationController.loading
                    ? Image.asset(Images.pick_marker, height: 50, width: 50)
                    : const CircularProgressIndicator(),
              ),
              // Show the place input fields & button for
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            EventsAppBar(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // showing the route
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: SizedBox(
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            _textField(
                                label: '',
                                hint: 'Endereço',
                                prefixIcon: const Icon(Icons.looks_one),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    locationController
                                        .fetchEndereco(_startAddress);
                                  },
                                ),
                                controller: startAddressController,
                                focusNode: startAddressFocusNode,
                                width: width,
                                locationCallback: (String value) {
                                  setState(() {
                                    _startAddress = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Show current location button
              /*
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 120.0),
                    child: ClipOval(
                      child: Material(
                        color: kPrimaryColor, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // inkwell color
                          child: const SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            locationController.getPosicao();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              */
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: const Text('Adicionar Evento'),
            icon: const Icon(Icons.event),
          ),
        );
      }),
    );
  }

  Future<void> _goToTheLake() async {
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
