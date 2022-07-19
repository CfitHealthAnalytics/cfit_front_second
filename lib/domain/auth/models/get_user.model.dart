import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetUserModel {
  final String genero, name, email, data_nascimento;

  const GetUserModel(
      {required this.genero,
      required this.name,
      required this.email,
      required this.data_nascimento});

  factory GetUserModel.fromData(GetUserModel data) {
    return GetUserModel(
        genero: data.genero,
        name: data.name,
        email: data.email,
        data_nascimento: data.data_nascimento);
  }

  static GetUserModel? fromStorage() {
    final storage = Get.find<GetStorage>();
    final user = storage.read<GetUserModel>('user_dados');
    return user;
  }

  Future<void> save() async {
    final storage = Get.find<GetStorage>();
    await storage.write('user_dados',
        {'genero': genero, 'name': name, 'email': email, 'name': name});
  }
}
