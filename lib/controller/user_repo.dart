import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/data/modal/response/userinfo_model.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.CUSTOMER_INFO_URI);
  }

  Future<Response> updateProfile(
      UserInfoModel userInfoModel, XFile data, String token) async {
    Map<String, String> _body = {};
    _body.addAll(<String, String>{
      'f_name': userInfoModel.name,
      'l_name': userInfoModel.sobrenome,
      'email': userInfoModel.email
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
}
