import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/use_cases/schedule_event_in_city_use_case.dart';

import 'event_details_navigation.dart';
import 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(
    this._navigation,
    this._scheduleEventsInCityUseCase,
  ) : super(EventDetailsState.empty());

  final ScheduleEventInCityUseCase _scheduleEventsInCityUseCase;

  final EventDetailsNavigation _navigation;

  void onBack() {
    _navigation.onBack();
  }

  void schedule(EventCity event) async {
    emit(
      state.copyWith(
          loadingRequest: true,
          errorMessage: null,
          status: EventDetailsStatus.none),
    );
    try {
      await _scheduleEventsInCityUseCase(
        event: event,
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
