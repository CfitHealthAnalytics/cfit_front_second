import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/categories_event_use_case.dart';
import 'package:cfit/domain/use_cases/create_event_public_use_case.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_navigation.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_state.dart';

class CreatePublicEventCubit extends Cubit<CreatePublicEventState> {
  CreatePublicEventCubit({
    required this.navigation,
    required this.categoriesEventUseCase,
    required this.createEventPublicUseCase,
    required this.user,
    required this.onCreate,
  }) : super(CreatePublicEventState.empty());

  final User user;
  final CreatePublicEventNavigation navigation;
  final CategoriesEventUseCase categoriesEventUseCase;
  final CreateEventPublicUseCase createEventPublicUseCase;
  final void Function(bool) onCreate;

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

  void onChangeAddress(String formattedAddress) {
    final street = formattedAddress.split(',')[0].trim();
    final number = formattedAddress.split(',')[1].split('-')[0].trim();
    final neighborhood = formattedAddress.split(',')[1].split('-')[1].trim();
    final address = state.address.copyWith(
      street: street,
      number: number,
      neighborhood: neighborhood,
    );
    emit(state.copyWith(address: address));
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

  Future<void> selectLocation() async {
    final address = await navigation.toMap();
    emit(
      state.copyWith(address: address),
    );
  }

  Future<List<String>> getCategoriesEvent() async {
    return await categoriesEventUseCase();
  }

  Future<void> action() async {
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
      int.parse(hourArray[1]),
      int.parse(hourArray[0]),
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
    } catch (e) {
      emit(state.copyWith(
        loadingRequest: false,
        status: CreatePublicEventStatus.failed,
      ));
    }
  }
}
