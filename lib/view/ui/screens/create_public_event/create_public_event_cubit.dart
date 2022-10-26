import 'package:bloc/bloc.dart';
import 'package:cfit/constants.dart';
import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/categories_event_use_case.dart';
import 'package:cfit/domain/use_cases/create_event_public_use_case.dart';
import 'package:cfit/domain/use_cases/edit_event_public_use_case.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_navigation.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_state.dart';
import 'package:flutter/foundation.dart';

class CreatePublicEventCubit extends Cubit<CreatePublicEventState> {
  CreatePublicEventCubit({
    required this.user,
    this.isEdit = false,
    required this.navigation,
    required this.categoriesEventUseCase,
    required this.createEventPublicUseCase,
    required this.editEventPublicUseCase,
    required this.onCreate,
    this.event,
    this.address,
  }) : super((address != null && isEdit != true)
            ? CreatePublicEventState.emptyOnlyAddress(address)
            : isEdit
                ? CreatePublicEventState.fromEvent(event!)
                : CreatePublicEventState.empty());

  final User user;
  final bool isEdit;
  final EventPublic? event;
  final Address? address;
  final CreatePublicEventNavigation navigation;
  final CategoriesEventUseCase categoriesEventUseCase;
  final CreateEventPublicUseCase createEventPublicUseCase;
  final EditEventPublicUseCase editEventPublicUseCase;
  final void Function(bool, [String]) onCreate;

  bool get isWeb => kIsWeb;
  String? get localization => state.address.formattedAddress;

  void onChangeName(String name) {
    emit(state.copyWith(name: name));
  }

  void onChangeDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void onChangeType(String? type) {
    emit(state.copyWith(type: type));
  }

  void onChangeCountMax(String countMax) {
    emit(state.copyWith(countMax: int.tryParse(countMax)));
  }

  void onChangeDate(String date) {
    emit(state.copyWith(date: date));
  }

  void onChangeHour(String hour) {
    emit(state.copyWith(hour: hour));
  }

  void onChangeStreet(String street) {
    emit(
      state.copyWith(
        address: state.address.copyWith(
          street: street,
        ),
      ),
    );
  }

  void onChangeNumber(String number) {
    emit(
      state.copyWith(
        address: state.address.copyWith(
          number: number,
        ),
      ),
    );
  }

  void onChangeNeighborhood(String neighborhood) {
    emit(
      state.copyWith(
        address: state.address.copyWith(
          neighborhood: neighborhood,
        ),
      ),
    );
  }

  void onChangeCity(String city) {
    emit(
      state.copyWith(
        address: state.address.copyWith(city: city),
      ),
    );
  }

  void allowEditLocalization() {
    emit(state.copyWith(editLocalization: true));
  }

  void forbidEditLocalization() {
    emit(state.copyWith(editLocalization: false));
  }

  void setErrorMessage(String errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  Future<List<String>> getCategoriesEvent() async {
    return await categoriesEventUseCase();
  }

  Future<void> _createEvent() async {
    emit(state.copyWith(
      errorMessage: null,
      loadingRequest: true,
    ));
    final dateArray = state.date.split('/');
    final hourArray = state.hour.split(':');
    final date = DateTime(
      int.parse(dateArray[2]),
      int.parse(dateArray[1]),
      int.parse(dateArray[0]),
      int.parse(hourArray[0]),
      int.parse(hourArray[1]),
    );
    try {
      await createEventPublicUseCase(
        address: state.address,
        name: state.name,
        description: state.description,
        date: date,
        type: state.type,
        countMax: state.countMax,
        userId: user.id,
      );
      emit(state.copyWith(
        errorMessage: null,
        loadingRequest: false,
        status: CreatePublicEventStatus.succeeds,
      ));
      navigation.back();
      onCreate(true);
    } on ForbiddenException {
      emit(state.copyWith(
        loadingRequest: false,
        status: CreatePublicEventStatus.failed,
      ));
      navigation.back();
      onCreate(false, EXCEPTION_MAX_LIMIT);
    } catch (e) {
      emit(state.copyWith(
        loadingRequest: false,
        status: CreatePublicEventStatus.failed,
      ));
      navigation.back();
      onCreate(false, UNEXPECTED_FAILED);
    }
  }

  Future<void> _editEvent() async {
    emit(state.copyWith(
      errorMessage: null,
      loadingRequest: true,
    ));
    final dateArray = state.date.split('/');
    final hourArray = state.hour.split(':');
    final date = DateTime(
      int.parse(dateArray[2]),
      int.parse(dateArray[1]),
      int.parse(dateArray[0]),
      int.parse(hourArray[0]),
      int.parse(hourArray[1]),
    );
    try {
      final success = await editEventPublicUseCase(
        address: state.address,
        name: state.name,
        description: state.description,
        date: date,
        type: state.type,
        countMax: state.countMax,
        eventId: event!.id,
      );
      emit(state.copyWith(
        errorMessage: null,
        loadingRequest: false,
        status: CreatePublicEventStatus.succeeds,
      ));
      navigation.back();
      onCreate(success);
    } catch (e) {
      emit(state.copyWith(
        loadingRequest: false,
        status: CreatePublicEventStatus.failed,
      ));
    }
  }

  Future<void> action() async {
    if (isEdit) {
      _editEvent();
    } else {
      await _createEvent();
    }
  }
}
