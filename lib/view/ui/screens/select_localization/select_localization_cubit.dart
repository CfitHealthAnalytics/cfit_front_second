import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/coordinates.dart';
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

  void action(LatLng selectedPosition) async {
    try {
      final addresses = await placemarkFromCoordinates(
        selectedPosition.latitude,
        selectedPosition.longitude,
      );
      final infoStreet = addresses.first.street?.split(',') ?? ['', 's/n'];
      final street = infoStreet[0];
      final number = infoStreet[1];
      _navigation.onBack(Address(
        street: street,
        neighborhood: addresses.first.subLocality ?? '',
        number: number.trim(),
        city: addresses.first.locality ?? '',
        coordinates: Coordinates(
          lat: selectedPosition.latitude,
          long: selectedPosition.longitude,
        ),
      ));
    } catch (e) {
      print(e);
    }
  }
}
