import 'package:bloc/bloc.dart';
import 'package:cfit/domain/use_cases/register_use_case.dart';
import 'package:cfit/view/ui/screens/register/register_navigation.dart';
import 'package:cfit/view/ui/screens/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._registerUseCase,
    this._navigation,
  ) : super(RegisterState.empty());

  final RegisterUseCase _registerUseCase;
  final RegisterNavigation _navigation;

  void onChangeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void onChangePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> authentication() async {
    emit(state.copyWith(loadingRequest: true, hasError: false));
    try {
      await _registerUseCase(
        email: state.email,
        password: state.password,
        dateBirth: state.dateBirth,
        name: state.name,
        genre: state.gender.toStringRepresentation(),
      );
      _navigation.toHome();
    } catch (e) {
      emit(state.copyWith(hasError: true));
    } finally {
      emit(state.copyWith(loadingRequest: false));
    }
  }

  void onBack() {
    _navigation.onBack();
  }
}
