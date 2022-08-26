import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/use_cases/schedule_event_public_use_case.dart';

import 'event_public_detail_navigation.dart';
import 'event_public_detail_state.dart';

class EventPublicDetailsCubit extends Cubit<EventPublicDetailsState> {
  EventPublicDetailsCubit(this._navigation, this._scheduleEventsInCityUseCase,
      {required this.alreadyScheduled})
      : super(EventPublicDetailsState.empty());

  final ScheduleEventPublicInCityUseCase _scheduleEventsInCityUseCase;

  final EventPublicDetailsNavigation _navigation;
  final bool alreadyScheduled;

  void onBack() {
    _navigation.onBack();
  }

  void action(EventPublic event) async {
    emit(
      state.copyWith(
        loadingRequest: true,
        errorMessage: null,
        status: EventPublicDetailsStatus.none,
      ),
    );
    try {
      await _scheduleEventsInCityUseCase(
          event: event, unschedule: alreadyScheduled);
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: null,
          status: EventPublicDetailsStatus.succeeds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: e.toString(),
          status: EventPublicDetailsStatus.failed,
        ),
      );
    }
  }
}
