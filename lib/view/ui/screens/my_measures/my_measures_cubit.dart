import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/bio_info.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/bio_info_use_case.dart';
import 'package:cfit/external/models/api.dart';

import 'my_measures_navigation.dart';
import 'my_mesures_state.dart';

class MyMeasureCubit extends Cubit<MyMeasureState> {
  MyMeasureCubit(
    this.bioInfoUseCase,
    this._navigation,
    this.user,
  ) : super(MyMeasureState.empty());

  final BioInfoUseCase bioInfoUseCase;
  final MyMeasureNavigation _navigation;
  final User user;

  Future<void> getDatas() async {
    emit(state.copyWith(
      loadingRequest: true,
      hasError: false,
    ));
    try {
      final responses = await Future.wait([
        bioInfoUseCase.getBioInfo(user.id),
        bioInfoUseCase.getChartData(user.id),
      ]);
      emit(state.copyWith(
          hasError: false,
          bioInfo: responses.first as BioInfo,
          chartData: responses.last as Map<DateTime, double>));
    } on ForbiddenException {
      emit(state.copyWith(hasError: true));
    } catch (e) {
      emit(state.copyWith(hasError: true));
    } finally {
      emit(state.copyWith(loadingRequest: false));
    }
  }

  void onBack() {
    _navigation.onBack();
  }

  void goToLogin() {
    _navigation.toLogin();
  }
}
