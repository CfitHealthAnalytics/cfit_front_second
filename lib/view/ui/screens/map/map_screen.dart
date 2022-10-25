import 'dart:async';

import 'package:cfit/view/ui/screens/map/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> googleMapsController = Completer();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();
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
          'Polos de academia',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
          future: cubit.onInit(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocBuilder<MapCubit, MapState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status.isFail) {
                  return Center(
                    child: Text(state.errorMessage ??
                        'Falha ao buscar os polos de academia'),
                  );
                }
                return GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-8.0433112, -34.934217),
                    zoom: 12,
                  ),
                  markers: state.markers,
                  onMapCreated: (controllerMap) {
                    googleMapsController.complete(controllerMap);
                  },
                  compassEnabled: true,
                  zoomControlsEnabled: true,
                );
              },
            );
          }),
    );
  }
}
