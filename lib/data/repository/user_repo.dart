import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/data/modal/response/userinfo_model.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  final _storage = Get.find<GetStorage>();

  Future<Response> getUserInfo() async {
    String token = getUserToken();
    apiClient.updateHeader(token, '', '');
    return await apiClient.postData(
        AppConstants.GET_USER, {"idtoken": token}, '');
  }

  Future<Response> updateProfile(
      UserInfoModel userInfoModel, XFile data, String token) async {
    Map<String, String> _body = {};
    _body.addAll(<String, String>{
      'f_name': userInfoModel.name,
      'l_name': userInfoModel.sobrenome,
      'email': userInfoModel.email,
    });
    return await apiClient.postMultipartData(
        AppConstants.UPDATE_PROFILE_URI, _body, [MultipartBody('image', data)]);
  }

  Future<Response> changePassword(UserInfoModel userInfoModel) async {
    return await apiClient.postData(
      AppConstants.UPDATE_PROFILE_URI,
      {
        'f_name': userInfoModel.name,
        'l_name': userInfoModel.sobrenome,
        'email': userInfoModel.email,
        'password': userInfoModel.password
      },
      '',
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    return await apiClient.postData(
      AppConstants.REFRESH_TOKEN,
      {'refresh_token': refreshToken},
      '',
    );
  }

  String getRefreshToken() {
    try {
      String refreshToken = _storage.read(AppConstants.REFRESH_TOKEN);
      return (refreshToken != '') ? refreshToken : '';
    } catch (e) {
      return '';
    }
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
}
