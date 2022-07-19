import 'dart:typed_data';

import 'package:cfit/data/modal/response/response_model.dart';
import 'package:cfit/data/modal/response/userinfo_model.dart';
import 'package:cfit/data/repository/user_repo.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/helper/network_info.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/util/Images.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  UserInfoModel _userInfoModel = UserInfoModel();

  //XFile _pickedFile = XFile(Images.profile);
  XFile _pickedFile = XFile(Images.profile);
  Uint8List _rawFile = Uint8List(0);
  bool _isLoading = false;

  final _storage = Get.find<GetStorage>();

  String _idLocal = '';

  bool SetLogin = false;

  String get idLocal => _idLocal;

  UserInfoModel get userInfoModel => _userInfoModel;

  XFile get pickedFile => _pickedFile;

  Uint8List get rawFile => _rawFile;

  bool get isLoading => _isLoading;

  setUserInfo(UserInfoModel userInfoModel) {
    _userInfoModel = userInfoModel;
  }

  bool getUserStatus = false;

  Future<ResponseModel> getUserInfo({bool reload = false}) async {
    if (_storage.read('user') != null) {
      _idLocal = _storage.read('user')!['localId'];
    }

    getUserStatus = false;

    ResponseModel _responseModel;
    if (_userInfoModel.name.isEmpty && getUserStatus == false) {
      //_pickedFile = null;
      //_rawFile = null;

      getUserStatus = true;

      Response response = await userRepo.getUserInfo();
      if (response.statusCode == 200) {
        _userInfoModel = UserInfoModel.fromJson(response.body);
        _responseModel = ResponseModel(true, 'successful');
        if (SetLogin == false) {
          refreshToken();
          //SetLogin = true;
        }
      } else {
        _responseModel = ResponseModel(false, response.statusText ?? '');
        _storage.remove(StorageConstants.tokenAuthorization);
        _storage.remove(StorageConstants.tokenAuthorization);
        Get.toNamed(Routes.login);
      }
    }
    //update();
    _responseModel = ResponseModel(false, '');
    return _responseModel;
  }

  Future<bool> isLoggedIn() async {
    return _storage.hasData(StorageConstants.tokenAuthorization);
  }

  Future<void> checkLogin() async {
    if (isLoggedIn() != false) {
      //print('logado');
    } else {
      //print('Deslogado');
    }
  }

  Future<ResponseModel> updateUserInfo(
      UserInfoModel updateUserModel, String token) async {
    _isLoading = true;
    update();
    ResponseModel _responseModel;
    Response response =
        await userRepo.updateProfile(updateUserModel, _pickedFile, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      _userInfoModel = updateUserModel;
      _responseModel = ResponseModel(true, response.bodyString ?? '');
      //_pickedFile = null;
      //_rawFile = null;
      getUserInfo();
    } else {
      _responseModel = ResponseModel(false, response.statusText ?? '');
    }
    update();
    return _responseModel;
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel _responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body["message"];
      _responseModel = ResponseModel(true, message);
    } else {
      _responseModel = ResponseModel(false, response.statusText ?? '');
    }
    update();
    return _responseModel;
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    ResponseModel _responseModel;

    /*
    Response response = await userRepo.changePassword(updatedUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body["message"];
      _responseModel = ResponseModel(true, message);
    } else {
      _responseModel = ResponseModel(false, response.statusText ?? '');
    }
    */
    update();
  }

  Future<ResponseModel> refreshToken() async {
    //print(userRepo.getRefreshToken());
    //print('teste');

    dynamic dpUser = _storage.read('users');

    //print(dpUser);

    //sharedPreferences.remove(AppConstants.TOKEN_REFRESH);

    ResponseModel _responseModel;

    _responseModel = ResponseModel(false, '');

    /*
    Response response = await userRepo.refreshToken('refreshToken');
    _isLoading = false;
    //print(response.body);
    if (response.statusCode == 200) {
      String message = response.body["message"];
      _responseModel = ResponseModel(true, message);

      await _storage.write(
        StorageConstants.tokenAuthorization,
        response.body['idToken'],
      );

      await _storage.write(
        AppConstants.REFRESH_TOKEN,
        response.body['refreshToken'],
      );
    } else {
      _responseModel = ResponseModel(false, response.statusText ?? '');
    }*/
    update();
    return _responseModel;
  }

  void pickImage() async {
    //_pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedFile = await NetworkInfo.compressImage(_pickedFile);
    _rawFile = await _pickedFile.readAsBytes();
    update();
  }

  void initData() {
    //_pickedFile = null;
    //_rawFile = null;
  }
}
