import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/data/modal/body/signup_body.dart';
import 'package:cfit/data/modal/response/auth_repo.dart';
import 'package:cfit/data/modal/response/response_model.dart';
import 'package:cfit/data/modal/response/userinfo_model.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController(this.authRepo) {
    _notification = authRepo.isNotificationActive();
  }

  final _storage = Get.find<GetStorage>();
  bool _isLoading = false;
  bool _notification = true;
  bool _acceptTerms = true;

  bool get isLoading => _isLoading;
  bool get notification => _notification;
  bool get acceptTerms => _acceptTerms;

  UserInfoModel _userInfoModel = UserInfoModel(
    email: '',
    data_nascimento: '',
    genero: '',
    name: '',
  );
  UserInfoModel get userInfoModel => _userInfoModel;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      //print(response.body['idToken']);

      authRepo.saveUserToken(response.body['idToken'],
          response.body['refreshToken'], response.body['expiresIn']);

      //await authRepo.updateToken();
      responseModel = ResponseModel(true, 'Login Efetuado com sucesso.');
    } else {
      responseModel = ResponseModel(false, response.body['detail']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<Response> checkinPublicCityEvent(String evento) async {
    Response response = await authRepo.checkinPublicCityEvent(evento);
    return response;
  }

  Future<Response> checkoutPublicCityEvent(String evento) async {
    Response response = await authRepo.checkoutPublicCityEvent(evento);
    return response;
  }

  Future<Response> getMyCityEvents() async {
    Response response = await authRepo.getMyCityEvents();
    return response;
  }

  Future<Response> getMyPublicEvents() async {
    Response response = await authRepo.getMyPublicEvents();
    return response;
  }

  Future<Response> checkoutCityEvent(String evento) async {
    Response response = await authRepo.checkoutCityEvent(evento);
    return response;
  }

  Future<Response> checkinCityEvent(String evento) async {
    Response response = await authRepo.checkinCityEvent(evento);
    return response;
  }

  Future<Response> comfirmationInEvents(String evento) async {
    Response response = await authRepo.comfirmationInEvents(evento);
    return response;
  }

  Future<Response> getPublicEvents({String modalidade = ''}) async {
    Response response = await authRepo.getPublicEvents();
    return response;
  }

  Future<Response> getCityEvents() async {
    Response response = await authRepo.getCityEvents();
    return response;
  }

  Future<Response> getModalidades() async {
    Response response = await authRepo.getModalidades();
    //print(response.body);

    return response;
  }

  Future<Response> getEventsModalidade(String filtro) async {
    Response response = await authRepo.getEventsModalidade(filtro);
    return response;
  }

  Future<Response> getFavoriteEvents() async {
    Response response = await authRepo.getFavoriteEvents();

    EventsModels returnEventos = EventsModels([]);

    if (response.statusCode == 200) {
      response.body.forEach((v) {
        EventsModel evento = EventsModel.fromJson(v);
        returnEventos.eventos.add(evento);
        //categoryIds.add(new CategoryIds.fromJson(v));
      });
      //print(returnEventos.eventos.length);
    }

    return response;
  }

  Future<Response> registerEvents(EventsModel evento) async {
    Response response = await authRepo.registerEvent(evento);

    /*
    Response response = await authRepo.getCityEvents();

    EventsModels returnEventos = EventsModels([]);

    if (response.statusCode == 200) {
      response.body.forEach((v) {
        EventsModel evento = EventsModel.fromJson(v);
        returnEventos.eventos.add(evento);
        //categoryIds.add(new CategoryIds.fromJson(v));
      });
      //print(returnEventos.eventos.length);
    } else {}

    */

    return response;
  }

  Future<Response> checkinCityEvents(EventsModel evento) async {
    Response response = await authRepo.registerEvent(evento);
    return response;
  }

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['idToken'],
          response.body['refreshToken'], response.body['expiresIn']);
      //await authRepo.updateToken();
      responseModel = ResponseModel(true, response.body["idToken"]);
    } else {
      responseModel = ResponseModel(false, response.body['detail']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> register(String nome, String email, String password,
      String dataNascimento, String genero) async {
    _isLoading = true;
    update();

    Response response =
        await authRepo.register(nome, email, password, dataNascimento, genero);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['idToken'],
          response.body['refreshToken'], response.body['expiresIn']);
      //await authRepo.updateToken();

      responseModel = ResponseModel(true, 'Cadastro Realizado com sucesso.');
    } else if (response.statusCode == 422) {
      if (response.body['detail'] == 'INVALID_PASSWORD') {
        //print('Senha Invalida');

        responseModel = ResponseModel(false, response.body['detail']);
      } else {
        responseModel = ResponseModel(false, response.body['detail']);
      }
    } else {
      //responseModel = Response(false, response.statusText);
      responseModel = ResponseModel(false, response.body['detail']);
    }

    //responseModel = ResponseModel(false, response.body['detail']);

    //print(response.body);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getUser() async {
    _isLoading = true;
    //update();
    ResponseModel responseModel;
    Response response = await authRepo.getUser();
    //print(response.body);
    //UserInfoModel userInfo;
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel(
        email: response.body['email'],
        data_nascimento: response.body['data_nascimento'],
        genero: response.body['genero'],
        name: response.body['name'],
      );

      Get.find<UserController>().setUserInfo(_userInfoModel);
      responseModel = ResponseModel(true, 'success');

      //Get.toNamed(Routes.dashboard);
    } else {
      _storage.remove(StorageConstants.tokenAuthorization);
      responseModel = ResponseModel(false, 'Invalidos ');

      //Get.toNamed(Routes.login);
    }
    _isLoading = false;
    //update();

    return responseModel;
  }

  Future<ResponseModel> refreshToken() async {
    _isLoading = true;
    //update();
    ResponseModel responseModel;
    Response response = await authRepo.refreshToken();
    //UserInfoModel userInfo;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, 'success');
    } else {
      responseModel = ResponseModel(false, 'Retorno incorreto.');
    }
    _isLoading = false;
    //update();

    return responseModel;
  }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(
      String email, String password, String countryCode) {
    authRepo.saveUserNumberAndPassword(email, password, countryCode);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }
}
