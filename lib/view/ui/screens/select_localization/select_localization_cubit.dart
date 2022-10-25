import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/coordinates.dart';
import 'package:cfit/view/ui/screens/select_localization/select_localization_response.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'select_localization_navigation.dart';
import 'select_localization_state.dart';

class SelectLocalizationCubit extends Cubit<SelectLocalizationState> {
  SelectLocalizationCubit(
    this._navigation, {
    required this.toCreateEvent,
  }) : super(SelectLocalizationState.empty());

  final SelectLocalizationNavigation _navigation;
  final bool toCreateEvent;

  void onBack() {
    _navigation.onBack();
  }

  void onChangePosition(LatLng position) {
    if (state.searchBarPressed) {
      emit(state.copyWith(searchBarPressed: false));
      return;
    }
    if (state.actionPressed == false) {
      emit(state.copyWith(position: position));
    }
  }

  void onChangeSearch(String search) {
    emit(state.copyWith(searchText: search));
  }

  void onLoadingPlaces(bool isLoading) {
    emit(state.copyWith(loadingPlaces: isLoading));
  }

  Future<Address> buildAddress(LatLng selectedPosition) async {
    try {
      final addresses = await placemarkFromCoordinates(
        selectedPosition.latitude,
        selectedPosition.longitude,
      );
      final infoStreet = addresses.first.street?.split(',') ?? ['', 's/n'];
      final street = infoStreet[0];
      final number = infoStreet[1];
      return Address(
        street: street,
        neighborhood: addresses.first.subLocality ?? '',
        number: number.trim(),
        city: addresses.first.locality ?? '',
        coordinates: Coordinates(
          lat: selectedPosition.latitude,
          long: selectedPosition.longitude,
        ),
      );
    } catch (e) {
      return Address(
        coordinates: Coordinates(
          lat: selectedPosition.latitude,
          long: selectedPosition.longitude,
        ),
      );
    }
  }

  void action() async {
    emit(state.copyWith(actionPressed: true));
    final selectedPosition = state.position;
    if (toCreateEvent) {
      _navigation.goToCreateEvent(
        SelectLocalizationResponse(
          address: await buildAddress(selectedPosition),
        ),
      );
    } else {
      _navigation.onBack(
        SelectLocalizationResponse(
          address: await buildAddress(selectedPosition),
        ),
      );
    }
    emit(state.copyWith(actionPressed: false));
  }
}
