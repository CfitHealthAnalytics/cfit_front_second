import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/register_use_case.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/view/ui/screens/register/register_navigation.dart';
import 'package:cfit/view/ui/screens/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._registerUseCase,
    this._navigation,
  ) : super(RegisterState.empty());

  final RegisterUseCase _registerUseCase;
  final RegisterNavigation _navigation;

  void onChangeName(String name) {
    emit(state.copyWith(name: name.trim()));
  }

  void onChangeGender(String? gender) {
    if (gender == null) return;
    emit(state.copyWith(gender: gender.trim().toGender()));
  }

  void onChangeDateBirth(String dateBirth) {
    emit(state.copyWith(dateBirth: dateBirth.trim()));
  }

  void onChangeEmail(String email) {
    emit(state.copyWith(email: email.trim()));
  }

  void onChangePassword(String password) {
    emit(state.copyWith(password: password.trim()));
  }

  void onChangeConfirmedPassword(String confirmedPassword) {
    emit(state.copyWith(confirmedPassword: confirmedPassword.trim()));
  }

  Future<void> register() async {
    emit(state.copyWith(
      loadingRequest: true,
      hasError: false,
      accountExists: false,
    ));
    try {
      await _registerUseCase(
        email: state.email,
        password: state.password,
        dateBirth: state.dateBirth,
        name: state.name,
        genre: state.gender.toStringRepresentation(),
      );
      _navigation.toHome();
    } on ForbiddenException {
      emit(state.copyWith(hasError: true, accountExists: true));
    } catch (e) {
      emit(state.copyWith(hasError: true));
    } finally {
      emit(state.copyWith(loadingRequest: false));
    }
  }

  void onBack() {
    _navigation.onBack();
  }
  void goToLogin() {
    _navigation.toLogin();
  }
}
