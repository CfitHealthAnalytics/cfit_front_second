import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/use_cases/schedule_event_in_city_use_case.dart';

import 'event_details_navigation.dart';
import 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(this._navigation, this._scheduleEventsInCityUseCase,
      {required this.alreadyScheduled})
      : super(EventDetailsState.empty());

  final ScheduleEventInCityUseCase _scheduleEventsInCityUseCase;

  final EventDetailsNavigation _navigation;
  final bool alreadyScheduled;

  void onBack() {
    _navigation.onBack();
  }

  void action(EventCity event) async {
    emit(
      state.copyWith(
        loadingRequest: true,
        errorMessage: null,
        status: EventDetailsStatus.none,
      ),
    );
    try {
      await _scheduleEventsInCityUseCase(
        event: event,
        unschedule: alreadyScheduled 
      );
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: null,
          status: EventDetailsStatus.succeeds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: e.toString(),
          status: EventDetailsStatus.failed,
        ),
      );
    }
  }
}
