import 'package:cfit/constants.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/util/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeAPpBar extends StatelessWidget {
  final _storage = Get.find<GetStorage>();

  HomeAPpBar({Key? key}) : super(key: key);

  void getUser() {
    Get.find<UserController>().getUserInfo().then((status) async {
      if (status.isSuccess) {
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(_storage.read(StorageConstants.user_dados)['name']);
    //getUser();
    return GetBuilder<UserController>(builder: (userController) {
      userController.getUserInfo();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bem-vindo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBackgroundBlack,
                ),
              ),
              Text(
                userController.userInfoModel.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kBackgroundBlack,
                ),
              ),
            ],
          ),
          Row(
            children: [
              /*
              Container(
                margin: const EdgeInsets.only(top: 30, right: 10),
                transform: Matrix4.rotationZ(100),
                child: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              */
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.mapa);
                  /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventsMaps()));
                        */
                },
                child:
                    ClipOval(child: Image.asset(Images.location_ap, width: 40)),
              ),
            ],
          ),
        ],
      );
    });
  }
}
