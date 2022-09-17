import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/confirmation_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/decline_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/delete_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/get_event_public_use_case.dart';

import 'my_event_navigation.dart';
import 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  MyEventCubit({
    required this.navigation,
    required this.event,
    required this.user,
    required this.getEventPublicUseCase,
    required this.deleteEventPublicUseCase,
    required this.confirmationEventPublicUseCase,
    required this.declineEventPublicUseCase,
  }) : super(MyEventState.empty(event));

  final MyEventNavigation navigation;
  final EventPublic event;
  final User user;
  final GetEventPublicUseCase getEventPublicUseCase;
  final DeleteEventPublicUseCase deleteEventPublicUseCase;
  final ConfirmationEventPublicUseCase confirmationEventPublicUseCase;
  final DeclineEventPublicUseCase declineEventPublicUseCase;

  void onBack() {
    navigation.onBack();
  }

  Future<void> getEventDetails({bool partialLoading = false}) async {
    if (partialLoading) {
      emit(state.copyWith(loadingPartial: true));
      final newEvent = await getEventPublicUseCase(event.id);
      emit(state.copyWith(event: newEvent, loadingPartial: false));
    } else {
      emit(state.copyWith(loadingRequest: true));
      final newEvent = await getEventPublicUseCase(event.id);
      emit(state.copyWith(event: newEvent, loadingRequest: false));
    }
  }

  void goToEdit() {
    navigation.toEditEvent(event, user, (created, [errorDetail]) {
      if (!created) {
        navigation.presentError(
          onRetry: () {
            navigation.onBack();
            goToEdit();
          },
        );
      } else {
        getEventDetails();
      }
    });
  }

  Future<bool> deleteEvent() async {
    try {
      await deleteEventPublicUseCase(event.id, user.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> confirmeParticipants(String userId) async {
    try {
      emit(state.copyWith(loadingPartial: true));
      await confirmationEventPublicUseCase(
        usersConfirmed: [userId],
        eventId: event.id,
      );
      getEventDetails(partialLoading: true);
    } catch (e) {
      emit(state.copyWith(loadingPartial: false));
    }
  }

  Future<void> declineParticipants(String userId) async {
    try {
      emit(state.copyWith(loadingPartial: true));
      await declineEventPublicUseCase(
        usersConfirmed: [userId],
        eventId: event.id,
      );
      getEventDetails(partialLoading: true);
    } catch (e) {
      emit(state.copyWith(loadingPartial: false));
    }
  }
}
