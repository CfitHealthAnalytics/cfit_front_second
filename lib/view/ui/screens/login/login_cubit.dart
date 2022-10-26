import 'package:bloc/bloc.dart';
import 'package:cfit/domain/use_cases/login_use_case.dart';
import 'package:cfit/view/ui/screens/login/login_navigation.dart';
import 'package:cfit/view/ui/screens/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._loginUseCase,
    this._navigation,
  ) : super(LoginState.empty());

  final LoginUseCase _loginUseCase;
  final LoginNavigation _navigation;

  void onChangeEmail(String email) {
    emit(state.copyWith(email: email.trim()));
  }

  void onChangePassword(String password) {
    emit(state.copyWith(password: password.trim()));
  }

  Future<void> authentication() async {
    emit(state.copyWith(loadingRequest: true, hasError: false));
    try {
      await _loginUseCase(
        email: state.email,
        password: state.password,
      );
      _navigation.toHome();
    } catch (e) {
      emit(state.copyWith(hasError: true));
    } finally {
      emit(state.copyWith(loadingRequest: false));
    }
  }

  void register() {
    _navigation.toRegister();
  }
  
  void recoverPassword() {
    _navigation.toRecoverPassword();
  }
}
