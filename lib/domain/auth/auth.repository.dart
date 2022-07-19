import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/infrastructure/dal/services/auth/auth.service.dart';
import 'package:cfit/infrastructure/dal/services/auth/dto/authenticate_user.body.dart';
import 'package:cfit/infrastructure/dal/services/user/user.service.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/infrastructure/translate/login.translate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository {
  final AuthService _authService;
  final UserService _userService;
  final _storage = Get.find<GetStorage>();

  AuthRepository({
    required AuthService authService,
    required UserService userService,
  })  : _authService = authService,
        _userService = userService;

  final bool _isLoading = false;
  final bool _notification = true;
  final bool _acceptTerms = true;

  bool get isLoading => _isLoading;

  bool get notification => _notification;

  bool get acceptTerms => _acceptTerms;

  Future<Response> authenticateUser(
      {required String login, required String password}) async {
    try {
      final body = AuthenticateUserBody(login: login, password: password);
      //final response = await _authService.authenticateUser(body);
      Response response = await _authService.login(login, password);

      return response;
      //return response;
    } catch (err) {
      throw UserNotFoundException(
        message: LoginTranslate.userPasswordWrongSnackbar,
      );
      rethrow;
    }
  }

  Future<dynamic> register({
    required String email,
    required String nome,
    required String password,
    required String dataNascimento,
    required String genero,
  }) async {
    Response response;
    try {
      //final response = await _authService.authenticateUser(body);
      Response response = await _authService.register(
          email, nome, password, dataNascimento, genero);
      return response;
    } catch (err) {
      return false;
      throw UserNotFoundException(
        message: LoginTranslate.userPasswordWrongSnackbar,
      );
    }
  }

  Future<dynamic> getUser() async {
    //try {
    final response = await _userService.getUserInfo();

    if (response.body['detail'] == 'INVALID_ID_TOKEN') {
      _storage.remove(StorageConstants.tokenAuthorization);
      Get.offAllNamed(Routes.login);
    } else {}
    //List<dynamic> user = response.body;
    //print(user);

    return response.body;

    //final user = UserModel.fromData(response.data!.user);
    //user.save();
    //return user;
    //} catch (err) {
    //print(err);
    //rethrow;
    //}
  }

  Future<bool> isAuthenticated() async {
    try {
      final hasToken = _storage.hasData(StorageConstants.tokenAuthorization);
      final hasUser = _storage.hasData(StorageConstants.user);
      return hasToken && hasUser;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _storage.erase();
    } catch (err) {
      rethrow;
    }
  }
}
