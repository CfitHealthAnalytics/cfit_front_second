import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/get_event_public_use_case.dart';

import 'my_event_navigation.dart';
import 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  MyEventCubit({
    required this.navigation,
    required this.event,
    required this.user,
    required this.getEventPublicUseCase,
  }) : super(MyEventState.empty(event));

  final MyEventNavigation navigation;
  final EventPublic event;
  final User user;
  final GetEventPublicUseCase getEventPublicUseCase;

  void onBack() {
    navigation.onBack();
  }

  Future<void> getEventDetails() async {
    emit(state.copyWith(loadingRequest: true));
    final newEvent = await getEventPublicUseCase(event.id);
    emit(state.copyWith(event: newEvent, loadingRequest: false));
  }

  void goToEdit() {
    navigation.toEditEvent(event, user, (created) {
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
}
