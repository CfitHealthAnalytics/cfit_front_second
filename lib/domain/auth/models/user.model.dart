import 'package:cfit/infrastructure/dal/services/data/user.data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserModel {
  final String kind,
      localId,
      email,
      displayName,
      idToken,
      refreshToken,
      expiresIn;

  const UserModel(
      {required this.kind,
      required this.localId,
      required this.email,
      this.displayName = '',
      required this.idToken,
      required this.refreshToken,
      required this.expiresIn});

  factory UserModel.fromData(UserData data) {
    return UserModel(
        kind: data.kind,
        localId: data.localId,
        email: data.email,
        displayName: data.displayName,
        idToken: data.idToken,
        refreshToken: data.refreshToken,
        expiresIn: data.expiresIn);
  }

  static UserModel? fromStorage() {
    final storage = Get.find<GetStorage>();
    final user = storage.read<UserModel>('user');
    return user;
  }

  Future<void> save() async {
    final storage = Get.find<GetStorage>();
    await storage.write('user', {
      'kind': kind,
      'localId': localId,
      'email': email,
      'displayName': displayName,
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn
    });
  }
}
