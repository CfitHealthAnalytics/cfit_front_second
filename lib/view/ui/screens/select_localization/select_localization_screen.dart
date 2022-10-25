import 'dart:async';

import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/foundation.dart' show Factory, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import 'select_localization_cubit.dart';
import 'select_localization_state.dart';

class SelectLocalizationScreen extends StatefulWidget {
  const SelectLocalizationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectLocalizationScreen> createState() =>
      _SelectLocalizationScreenState();
}

class _SelectLocalizationScreenState extends State<SelectLocalizationScreen> {
  final isWeb = kIsWeb;
  late final GooglePlace googlePlace;
  Completer<GoogleMapController> controller = Completer();
  Marker selectedLocation = const Marker(
    markerId: MarkerId('selected-location'),
    position: LatLng(
      -8.056222986074129,
      -34.93490595758101,
    ),
  );
  Marker centeredMarker = const Marker(
    markerId: MarkerId('centered-location'),
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
    googlePlace = GooglePlace('AIzaSyCcUXHKcKWROyT4ozJJ-XFP2d0xR8Tjc40');
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

      final cubit = context.read<SelectLocalizationCubit>();

      cubit.onChangePosition(currentLocalization);
    } on PermissionDeniedException {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Navigator.pop(context);
      } else {
        return _getUserLocation();
      }
    }
  }

  Future<void> goToSearch(String place) async {
    final cubit = context.read<SelectLocalizationCubit>();
    cubit.onLoadingPlaces(true);
    final places =
        await googlePlace.search.getFindPlace(place, InputType.TextQuery);
    final mapControl = await controller.future;
    if (places != null) {
      final placeFounded = places.candidates?.first;
      if (placeFounded != null) {
        final localization =
            await googlePlace.details.get(placeFounded.placeId!);
        if (localization != null &&
            localization.result != null &&
            localization.result!.geometry != null &&
            localization.result!.geometry!.location != null &&
            localization.result!.geometry!.location!.lat != null &&
            localization.result!.geometry!.location!.lng != null) {
          mapControl.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  localization.result!.geometry!.location!.lat!,
                  localization.result!.geometry!.location!.lng!,
                ),
                zoom: 17,
              ),
            ),
          );
        }
      } else {
        return;
      }
    }
    cubit.onLoadingPlaces(false);
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
      body: BlocBuilder<SelectLocalizationCubit, SelectLocalizationState>(
        buildWhen: (previous, current) => previous.position != current.position,
        builder: (context, state) {
          final markers = {
            Marker(
              markerId: MarkerId('marker-id-${state.position.hashCode}'),
              position: state.position,
            )
          };

          return Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: [
              GoogleMap(
                initialCameraPosition: kGooglePlex,
                markers: markers,
                onMapCreated: (controllerMap) {
                  controller.complete(controllerMap);
                },
                compassEnabled: true,
                onCameraMove: (cameraPosition) {
                  cubit.onChangePosition(cameraPosition.target);
                },
              ),
              BlocBuilder<SelectLocalizationCubit, SelectLocalizationState>(
                  buildWhen: (previous, current) =>
                      (previous.searchText != current.searchText) ||
                      (previous.loadingPlaces != current.loadingPlaces),
                  builder: (context, state) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            InputText(
                              hintText: 'Procurar localização',
                              onChanged: cubit.onChangeSearch,
                              type: InputTextType.text,
                            ).withPaddingOnly(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            Positioned(
                              right: 16,
                              top: 20,
                              child: IconButton(
                                onPressed: () {
                                  if (state.searchText != null &&
                                      state.searchText!.isNotEmpty) {
                                    goToSearch(state.searchText!);
                                  }
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                        state.loadingPlaces
                            ? const LinearProgressIndicator()
                                .withPaddingSymmetric(horizontal: 16)
                            : const SizedBox.shrink(),
                      ],
                    );
                  }),
            ],
          );
        },
      ),
      floatingActionButton: ButtonAction(
        text: cubit.toCreateEvent ? "+  Criar Evento" : "Finalizar",
        type: ButtonActionType.chip,
        onPressed: cubit.action,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ).withPaddingOnly(bottom: 16),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
