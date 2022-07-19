import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/domain/core/abstractions/http_connect.interface.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/domain/core/exceptions/default.exception.dart';
import 'package:cfit/infrastructure/dal/services/user/dto/get_user_info.response.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService {
  final IHttpConnect _connect;
  final _storage = Get.find<GetStorage>();
  UserService(IHttpConnect connect) : _connect = connect;

  String get _prefix => '/register_user/';

  Future<Response> getUserInfo() async {
    ApiClient apiClient = ApiClient(AppConstants.BASE_URL);

    apiClient.updateHeader(
        _storage.read(StorageConstants.tokenAuthorization), '', '');

    Response retorno = await apiClient.postData(AppConstants.GET_USER,
        {"idtoken": _storage.read(StorageConstants.tokenAuthorization)}, {});

    bool statusCode = false;
    if (retorno.statusCode == '200') {
      statusCode = true;
    }
    /*GetUserInfoResponse getUser =
        GetUserInfoResponse({statusCode, retorno.body, retorno.statusText});*/

    return retorno;

    /*

    final response = await _connect.get(
      _prefix,
      decoder: (value) => GetUserInfoResponse.fromJson(
        value as Map<String, dynamic>,
      ),
    );
    */

    /*
    if (response.success) {
      return response.payload!;
    } else {
      switch (response.statusCode) {
        default:
          throw DefaultException(message: response.payload!.error!);
      }
    }
    */
  }
}
