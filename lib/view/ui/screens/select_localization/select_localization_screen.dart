import 'dart:async';

import 'package:cfit/view/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'select_localization_cubit.dart';

class SelectLocalizationScreen extends StatefulWidget {
  const SelectLocalizationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectLocalizationScreen> createState() =>
      _SelectLocalizationScreenState();
}

class _SelectLocalizationScreenState extends State<SelectLocalizationScreen> {
  Completer<GoogleMapController> controller = Completer();
  Marker selectedLocation = const Marker(
    markerId: MarkerId('selected-location'),
    position: LatLng(
      -8.056222986074129,
      -34.93490595758101,
    ),
  );
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(
      -8.056222986074129,
      -34.93490595758101,
    ),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      final mapControl = await controller.future;
      final currentLocalization = LatLng(
        position.latitude,
        position.longitude,
      );
      mapControl.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocalization,
            zoom: 17,
          ),
        ),
      );
      setState(() {
        selectedLocation = selectedLocation.copyWith(
          positionParam: currentLocalization,
        );
      });
    } on PermissionDeniedException {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Navigator.pop(context);
      } else {
        return _getUserLocation();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectLocalizationCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
          onPressed: cubit.onBack,
        ),
        title: const Text(
          'Map',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        markers: {selectedLocation},
        onMapCreated: (controllerMap) {
          controller.complete(controllerMap);
        },
        onTap: (newPosition) {
          setState(() {
            selectedLocation =
                selectedLocation.copyWith(positionParam: newPosition);
          });
        },
      ),
      floatingActionButton: ButtonAction(
        text: cubit.toCreateEvent ? "+  Criar Evento" : "Finalizar",
        type: ButtonActionType.chip,
        onPressed: () => cubit.action(selectedLocation.position),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
