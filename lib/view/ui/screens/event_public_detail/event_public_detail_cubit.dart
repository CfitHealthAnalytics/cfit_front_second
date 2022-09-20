import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/schedule_event_public_use_case.dart';

import 'event_public_detail_navigation.dart';
import 'event_public_detail_state.dart';

class EventPublicDetailsCubit extends Cubit<EventPublicDetailsState> {
  EventPublicDetailsCubit(
    this._navigation,
    this._scheduleEventsInCityUseCase,
    this.eventPublic,
    this.user, {
    required this.alreadyScheduled,
  }) : super(EventPublicDetailsState.empty());

  final ScheduleEventPublicInCityUseCase _scheduleEventsInCityUseCase;

  final EventPublicDetailsNavigation _navigation;
  final bool alreadyScheduled;
  final EventPublic eventPublic;
  final User user;

  bool get isFilled =>
      eventPublic.usersCheckIn.length == eventPublic.countMaxUsers;

  bool get isRejected => eventPublic.usersRejection.contains(user.id);

  void onBack() {
    _navigation.onBack();
  }

  void action() async {
    emit(
      state.copyWith(
        loadingRequest: true,
        errorMessage: null,
        status: EventPublicDetailsStatus.none,
      ),
    );
    try {
      await _scheduleEventsInCityUseCase(
        event: eventPublic,
        unschedule: alreadyScheduled,
      );
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
