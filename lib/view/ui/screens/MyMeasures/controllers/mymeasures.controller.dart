import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/domain/auth/models/get_user.model.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';

import 'package:get/get.dart';

class MyMeasuresController extends GetxController {
  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();

  MyMeasuresController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<void> onReady() async {
    super.onReady();
    print('Carregando');
    try {
      _loadingController.isLoading = true;
      userGet.value = await _authRepository.getUser();
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
    } finally {
      _loadingController.isLoading = false;
    }
  }

  final userGet = Rxn<GetUserModel>();
}
