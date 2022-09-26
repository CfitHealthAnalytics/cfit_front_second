import 'package:bloc/bloc.dart';
import 'package:cfit/domain/use_cases/recover_password_use_case.dart';
import 'package:cfit/external/models/api.dart';

import 'recover_password_navigation.dart';
import 'recover_password_state.dart';

class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  RecoverPasswordCubit(
    this._recoverPasswordUseCase,
    this._navigation,
  ) : super(RecoverPasswordState.empty());

  final RecoverPasswordUseCase _recoverPasswordUseCase;
  final RecoverPasswordNavigation _navigation;

  void onBack() {
    _navigation.goBack();
  }

  void onChangeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void onChangeConfirmEmail(String confirmEmail) {
    emit(state.copyWith(confirmEmail: confirmEmail));
  }

  Future<void> recoverPassword() async {
    emit(state.copyWith(loadingRequest: true, hasError: false));
    try {
      await _recoverPasswordUseCase(
        email: state.email,
      );
      emit(state.copyWith(status: Status.success));
    } on NotFoundException {
      emit(state.copyWith(hasError: true));
      emit(state.copyWith(status: Status.notFound));
    } catch (e) {
      emit(state.copyWith(hasError: true));
      emit(state.copyWith(status: Status.fail));
    } finally {
      emit(state.copyWith(loadingRequest: false));
    }
  }

  void register() {
    _navigation.toRegister();
  }
}
