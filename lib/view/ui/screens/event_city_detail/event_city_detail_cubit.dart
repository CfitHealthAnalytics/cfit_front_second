import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/use_cases/schedule_event_in_city_use_case.dart';

import 'event_city_detail_navigation.dart';
import 'event_city_detail_state.dart';

class EventCityDetailsCubit extends Cubit<EventCityDetailsState> {
  EventCityDetailsCubit(this._navigation, this._scheduleEventsInCityUseCase,
      {required this.alreadyScheduled})
      : super(EventCityDetailsState.empty());

  final ScheduleEventCityInCityUseCase _scheduleEventsInCityUseCase;

  final EventCityDetailsNavigation _navigation;
  final bool alreadyScheduled;

  void onBack() {
    _navigation.onBack();
  }

  void action(EventCity event) async {
    emit(
      state.copyWith(
        loadingRequest: true,
        errorMessage: null,
        status: EventCityDetailsStatus.none,
      ),
    );
    try {
      await _scheduleEventsInCityUseCase(
          event: event, unschedule: alreadyScheduled);
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: null,
          status: EventCityDetailsStatus.succeeds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: e.toString(),
          status: EventCityDetailsStatus.failed,
        ),
      );
    }
  }
}
