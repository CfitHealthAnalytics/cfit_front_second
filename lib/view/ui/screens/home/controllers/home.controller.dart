import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/domain/auth/models/get_user.model.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository;
  final _loadingController = Get.find<LoadingController>();

  UserController user = Get.find<UserController>();

  HomeController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final List<EventModalidade> _modalidades = [];
  List<EventModalidade> get modalidades => _modalidades;

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      user.getUserInfo();
      _loadingController.isLoading = true;
      //userGet.value = await _authRepository.getUser();
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
    } finally {
      _loadingController.isLoading = false;
    }
  }

  Future<List<EventModalidade>> getModalidades() async {
    //_modalidades = await Get.find<EventsController>().getModalidades();
    return _modalidades;
  }

  final userGet = Rxn<GetUserModel>();
}
