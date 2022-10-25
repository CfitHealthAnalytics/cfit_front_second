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
      print('antes de chamar o usecase');
      final poles = await getPolesUseCase();
      print('depois de chamar o usecase');
      print('poles: $poles');
      buildMarkers(poles);
      emit(state.copyWith(poles: poles, status: MapStatus.success));
    } catch (e, stack) {
      print('error: $e');
      print('stack: $stack');
      emit(
        state.copyWith(
          status: MapStatus.fail,
          errorMessage: 'Falha ao buscar os Polos',
        ),
      );
    }
  }

  void buildMarkers(List<Pole> poles) {
    print('passou aqui');
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
    print('newMarker: $newMarkers');
    emit(state.copyWith(markers: newMarkers));
  }
}
