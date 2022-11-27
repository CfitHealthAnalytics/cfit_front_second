import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/poles.dart';
import 'package:cfit/domain/use_cases/get_poles_use_case.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/ui/screens/map/map_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_navigation.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(
    this._navigation,
    this.getPolesUseCase,
  ) : super(MapState.empty());

  final MapNavigation _navigation;
  final GetPolesUseCase getPolesUseCase;

  void onBack() {
    _navigation.onBack();
  }

  Future<void> onInit() async {
    emit(state.copyWith(status: MapStatus.loading));
    try {
      final poles = await getPolesUseCase();
      buildMarkers(poles);
      emit(state.copyWith(poles: poles, status: MapStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: MapStatus.fail,
          errorMessage: 'Falha ao buscar os Polos',
        ),
      );
    }
  }

  void buildMarkers(List<Pole> poles) {
    final newMarkers = poles
        .map(
          (pole) => Marker(
            markerId: MarkerId('${pole.name}-${pole.hashCode}'),
            position: LatLng(
              pole.coordinates.lat!,
              pole.coordinates.long!,
            ),
            infoWindow: InfoWindow(
              title: 'Polo ${pole.name.upperOnlyFirstLetter()}',
            ),
          ),
        )
        .toSet();
    emit(state.copyWith(markers: newMarkers));
  }
}
