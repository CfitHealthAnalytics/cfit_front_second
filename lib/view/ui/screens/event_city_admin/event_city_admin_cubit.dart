import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/use_cases/confirmation_event_in_city_use_case.dart';

import 'event_city_admin_navigation.dart';
import 'event_city_admin_state.dart';

class EventCityAdminCubit extends Cubit<EventCityAdminState> {
  EventCityAdminCubit(
    this._navigation,
    this._confirmationEventInCityUseCase,
  ) : super(EventCityAdminState.empty());

  final EventCityAdminNavigation _navigation;
  final ConfirmationEventInCityUseCase _confirmationEventInCityUseCase;

  void setUserInConfirmation(String id) {
    emit(state.copyWith(listSelected: [id, ...state.listSelected]));
  }

  void removeUserInConfirmation(String id) {
    final listSelected = state.listSelected;
    listSelected.remove(id);
    emit(state.copyWith(listSelected: [...listSelected]));
  }

  void onBack() {
    _navigation.onBack();
  }

  void action(EventCity eventCity) async {
    emit(
      state.copyWith(
        loadingRequest: true,
        status: EventCityAdminStatus.none,
      ),
    );
    try {
      await _confirmationEventInCityUseCase(
        eventId: eventCity.id,
        usersConfirmed: state.listSelected,
      );
      emit(
        state.copyWith(
          loadingRequest: false,
          status: EventCityAdminStatus.succeeds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingRequest: false,
          errorMessage: e.toString(),
          status: EventCityAdminStatus.failed,
        ),
      );
    }
  }
}
