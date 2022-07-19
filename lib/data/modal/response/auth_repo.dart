import 'dart:async';

import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/data/modal/body/signup_body.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  final _storage = Get.find<GetStorage>();

  AuthRepo(this.apiClient, this.sharedPreferences);

  final bool _isLoading = false;

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient
        .postData(AppConstants.REGISTER_URI, signUpBody.toJson(), {});
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"email": email, "password": password}, {});
  }

  Future<Response> getCityEvents() async {
    setToken();
    return await apiClient.getData(AppConstants.GET_CITY_EVENTS);
  }

  Future<Response> getPublicEvents() async {
    setToken();
    return await apiClient.getData(AppConstants.GET_PUBLIC_EVENTS);
  }

  Future<Response> getModalidades() async {
    setToken();
    return await apiClient.getData(AppConstants.GET_MODALIDADES_EVENTS);
  }

  Future<Response> getEventsModalidade(String filtro) async {
    setToken();
    return await apiClient.getData('/public_events_filters?' + filtro);
  }

  Future<Response> getFavoriteEvents() async {
    setToken();
    return await apiClient.getData(
      AppConstants.GET_MY_CITY_EVENTS +
          '?user_id=' +
          _storage.read('user')?['localId'],
    );
  }

  Future<Response> register(String nome, String email, String password,
      String dataNascimento, String genero) async {
    setToken();
    return await apiClient.postData(
        AppConstants.REGISTER_URI,
        {
          "email": email,
          "nome": nome,
          "data_nascimento": dataNascimento,
          "genero": genero,
          "password": password
        },
        '');
  }

  Future<Response> checkoutPublicCityEvent(String id) async {
    setToken();
    return await apiClient.postData(
      '/checkout_public_events/?id_event=' +
          id +
          '&user=' +
          _storage.read('user')?['localId'],
      {},
      '',
    );
  }

  Future<Response> getMyCityEvents() async {
    setToken();
    return await apiClient.getData(
      '/get_city_events/my_city_events?user_id=' +
          _storage.read('user')?['localId'],
    );
  }

  Future<Response> getMyPublicEvents() async {
    setToken();
    return await apiClient.getData(
      '/get_public_events/my_public_events?user_id=' +
          _storage.read('user')?['localId'],
    );
  }

  Future<Response> checkinPublicCityEvent(String id) async {
    setToken();
    return await apiClient.postData(
        '/checkin_public_events/?id_event=' +
            id +
            '&user=' +
            _storage.read('user')?['localId'],
        {},
        '');
    /*return await apiClient.postData(
        AppConstants.CHECKOUT_CITY_EVENTS, {"id_event": id}, '');*/
  }

  Future<Response> checkoutCityEvent(String id) async {
    setToken();
    return await apiClient.postData(
        '/checkout_city_events/?id_event=' +
            id +
            '&user=' +
            _storage.read('user')?['localId'],
        [],
        '');
  }

  Future<Response> checkinCityEvent(String id) async {
    setToken();
    return await apiClient.postData(
        '/checkin_city_events/?id_event=' +
            id +
            '&user=' +
            _storage.read('user')?['localId'],
        [],
        '');
  }

  Future<Response> comfirmationInEvents(String id) async {
    setToken();
    return await apiClient.postData('/comfirmation_in_events/',
        {"id_event": id, "user": _storage.read('user')?['localId']}, '');
    /*return await apiClient.postData(
        AppConstants.CHECKOUT_CITY_EVENTS, {"id_event": id}, '');*/
  }

  Future<Response> registerEvent(EventsModel evento) async {
    setToken();
    return await apiClient.postData(
        AppConstants.REGISTER_EVENT +
            '?user_id=' +
            _storage.read('user')?['localId'],
        {
          "cidade": evento.cidade,
          "bairro": evento.bairro,
          "rua": evento.rua,
          "number": evento.numero,
          "name": evento.nome,
          "lat": evento.coordenadas?.latitude,
          "long": evento.coordenadas?.longitude,
          "tipo": evento.tipo,
          "descricao": evento.descricao,
          "status": true,
          "qtd_max_user": evento.qtd_user,
          "horario_de_inicio": evento.horario_de_inicio
        },
        '');
  }

  Future<Response> updateToken() async {
    String _deviceToken;
    if (GetPlatform.isIOS) {
      _deviceToken = '';
    } else {
      _deviceToken = await _saveDeviceToken();
    }
    if (!GetPlatform.isWeb) {
      //FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }
    return await apiClient.postData(AppConstants.TOKEN_URI,
        {"_method": "put", "cm_firebase_token": _deviceToken}, {});
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        //_deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    //print('--------Device Token---------- ' + _deviceToken);
    return _deviceToken;
  }

  Future<Response> checkEmail(String email) async {
    return await apiClient
        .postData(AppConstants.CHECK_EMAIL_URI, {"email": email}, {});
  }

  Future<Response> verifyEmail(String email, String token) async {
    return await apiClient.postData(
        AppConstants.VERIFY_EMAIL_URI, {"email": email, "token": token}, {});
  }

  Future<Response> verifyPhone(String phone, String otp) async {
    return await apiClient.postData(
        AppConstants.VERIFY_PHONE_URI, {"phone": phone, "otp": otp}, {});
  }

  Future<Response> refreshToken() async {
    return await apiClient.postData(AppConstants.REFRESH_TOKEN, {
      "refresh_token": sharedPreferences.getString(AppConstants.REFRESH_TOKEN)
    }, {});
  }

  // for  user token
  Future<bool> saveUserToken(
      String token, String refreshToken, String expiresIn) async {
    //apiClient.token = token;
    apiClient.updateHeader(
        token, null, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));

    await sharedPreferences.setString(AppConstants.TOKEN_REFRESH, refreshToken);
    await sharedPreferences.setString(AppConstants.TOKEN_EXPIRESIN, expiresIn);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<Response> getUser() async {
    String token = getUserToken();

    apiClient.updateHeader(token, '', '');

    return await apiClient
        .postData(AppConstants.GET_USER, {"idtoken": token}, {});
  }

  void setToken() {
    String token = getUserToken();
    apiClient.updateHeader(token, '', '');
  }

  String getUserToken() {
    try {
      return (_storage.read(StorageConstants.tokenAuthorization) != null)
          ? _storage.read(StorageConstants.tokenAuthorization)
          : '';
    } catch (e) {
      return '';
    }
    //return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return _storage.hasData(StorageConstants.tokenAuthorization);
  }

  bool clearSharedData() {
    if (!GetPlatform.isWeb) {
      /*
      FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      apiClient.postData(AppConstants.TOKEN_URI,
          {"_method": "put", "cm_firebase_token": '@'}, {});
          */
    }
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.TOKEN_REFRESH);
    sharedPreferences.remove(AppConstants.TOKEN_EXPIRESIN);
    sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    //apiClient.token = null;
    apiClient.updateHeader(null, null, null);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(
      String email, String password, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
      await sharedPreferences.setString(
          AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  void setNotificationActive(bool isActive) {
    if (isActive) {
      //updateToken();
    } else {
      if (!GetPlatform.isWeb) {
        /*
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
        if (isLoggedIn()) {
          FirebaseMessaging.instance.unsubscribeFromTopic(
              'zone_${Get.find<LocationController>().getUserAddress().zoneId}_customer');
        }
        */
      }
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }
}
