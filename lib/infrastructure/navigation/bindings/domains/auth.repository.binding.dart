import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/data/repository/user_repo.dart';
import 'package:cfit/domain/auth/auth.repository.dart';
import 'package:cfit/infrastructure/dal/connect.dart';
import 'package:cfit/infrastructure/dal/services/auth/auth.service.dart';
import 'package:cfit/infrastructure/dal/services/user/user.service.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:get/get.dart';

class AuthRepositoryBinding {
  late AuthRepository _authRepository;
  late AuthController _authController;
  late UserRepo _userRepo;
  late ApiClient _apiClient;

  AuthRepository get repository => _authRepository;
  AuthController get authController => _authController;
  UserRepo get userRepo => _userRepo;
  ApiClient get apiClient => _apiClient;

  AuthRepositoryBinding() {
    final getConnect = Get.find<GetConnect>();
    final connect = Connect(connect: getConnect);
    ApiClient apiClient = ApiClient(AppConstants.BASE_URL);
    _apiClient = apiClient;

    final authService = AuthService(apiClient, connect);
    final userService = UserService(connect);
    _userRepo = UserRepo(apiClient: apiClient);
    _authRepository = AuthRepository(
      authService: authService,
      userService: userService,
    );
    _authController = AuthController(Get.find());
  }
}
