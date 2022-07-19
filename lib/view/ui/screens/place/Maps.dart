import 'dart:async';

import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/place/MapsController.dart';
import 'package:cfit/view/ui/screens/place/place_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

//class Maps extends StatelessWidget {
class Maps extends GetView<MapsController> {
  //  final Completer<GoogleMapController> _controller = Completer();

  final MapsController _controller = Get.put(MapsController());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    //bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    //tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  static const LatLng _center = LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    //setState(() {
    _currentMapType =
        _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    //});
  }

  void _onAddMarkerButtonPressed() {
    //setState(() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition.toString()),
      position: _lastMapPosition,
      infoWindow: const InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
    ));
    //});
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.google.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.long);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 0, right: 25, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, right: 10),
                          transform: Matrix4.rotationZ(100),
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.notifications_none_outlined,
                                size: 30,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.more_horiz_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: const <Widget>[
            PlaceMap(center: LatLng(45.521563, -122.677433)),
          ],
        ),
        /*floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),*/
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.google.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
