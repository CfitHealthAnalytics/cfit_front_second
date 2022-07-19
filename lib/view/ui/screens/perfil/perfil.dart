import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/view/base/custom_image.dart';
import 'package:cfit/view/base/footer_view.dart';
import 'package:cfit/view/ui/screens/perfil/widget/prodile_button.dart';
import 'package:cfit/view/ui/screens/perfil/widget/profile_bg_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PerfilScreen extends StatefulWidget {
  @override
  State<PerfilScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<PerfilScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  final _storage = Get.find<GetStorage>();
  @override
  void initState() {
    super.initState();

    //if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
    Get.find<UserController>().getUserInfo();
    //}
  }

  @override
  Widget build(BuildContext context) {
    //String qrData = "CFjzbLMGuoiaXsd7oMpBH3O7tXSv7221111997M";
    return Scaffold(
      //appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      //endDrawer: MenuDrawer(),
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? const Center(child: CircularProgressIndicator())
            : ProfileBgWidget(
                backButton: true,
                circularImage: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).cardColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const ClipOval(
                      child: CustomImage(
                    //image: Images.profile,
                    image:
                        'https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg',
                    //'${Get.find<SplashController>().configModel.baseUrls!.customerImageUrl}'
                    //'/${(_isLoggedIn) ? userController.userInfoModel.image ?? '' : ''}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
                ),
                mainWidget: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FooterView(
                    minHeight: 0.35,
                    child: Center(
                      child: Container(
                        width: Dimensions.WEB_MAX_WIDTH,
                        color: Theme.of(context).cardColor,
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Theme.of(context).cardColor),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const ClipOval(
                                child: CustomImage(
                              //image: Images.profile,
                              image:
                                  'https://icon-library.com/images/profile-png-icon/profile-png-icon-2.jpg',
                              //'${Get.find<SplashController>().configModel.baseUrls!.customerImageUrl}'
                              //'/${(_isLoggedIn) ? userController.userInfoModel.image ?? '' : ''}',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                          ),
                          Text(
                            'Nome ' '' +
                                (_isLoggedIn
                                    ? '${userController.userInfoModel.name} ${userController.userInfoModel.sobrenome}'
                                    : 'guest'.tr),
                            /*style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),*/
                          ),
                          //const SizedBox(height: 30),
                          SizedBox(height: _isLoggedIn ? 30 : 0),
                          _isLoggedIn
                              ? GetBuilder<AuthController>(
                                  builder: (authController) {
                                  return ProfileButton(
                                    icon: Icons.notifications,
                                    title: 'Notificações',
                                    isButtonActive: authController.notification,
                                    onTap: () {
                                      authController.setNotificationActive(
                                          !authController.notification);
                                    },
                                  );
                                })
                              : const SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? Dimensions.PADDING_SIZE_SMALL
                                  : 0),
                          _isLoggedIn
                              ? ProfileButton(
                                  icon: Icons.lock,
                                  title: 'Avaliações',
                                  onTap: () {
                                    Get.toNamed(Routes.mymeasures);
                                  })
                              : const SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? Dimensions.PADDING_SIZE_SMALL
                                  : 0),
                          ProfileButton(
                              icon: Icons.edit,
                              title: 'Meus Dados',
                              onTap: () {
                                print('Editar');
                                /*
                                Get.toNamed(
                                    RouteHelper.getUpdateProfileRoute());
                                    */
                              }),
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          const Text(
                            'QR code de identificação',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Courier',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          QrImage(
                            data: 'CF*' +
                                userController.idLocal +
                                '*' +
                                userController.userInfoModel.data_nascimento
                                    .replaceAll('/', '') +
                                '*' +
                                ((userController.userInfoModel.genero ==
                                        'masculino')
                                    ? 'M'
                                    : 'F'),
                            //size: (Get.width * 0.6),
                            size: 130,
                            version: QrVersions.auto,
                            gapless: false,
                          ),

                          /// LOG OUT BUTTON
                          ElevatedButton(
                            onPressed: () {
                              logout();
                            },
                            child: const Text("Sair"),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }

  void logout() {
    _storage.remove(StorageConstants.tokenAuthorization);
    Get.offAllNamed(Routes.login);
  }
}

/*

class PerfilScreen extends GetView<EventsController> {
  final _storage = Get.find<GetStorage>();

  @override
  Widget build(BuildContext context) {
    String qrData = "CFjzbLMGuoiaXsd7oMpBH3O7tXSv7221111997M";
    //Future<EventsModels> eventos = Get.find<AuthController>().getCityEvents();
    //Future<dynamic> eventos = Get.find<AuthController>().getCityEvents();
    //Get.find<AuthController>().getCityEvents();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
          Column(
            children: [
              const EventsAppBar(),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Image.asset(
                'assets/images/avatar.png',
                fit: BoxFit.cover,
                height: 180,
                width: 180,
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Text(
                Get.find<AuthController>().userInfoModel.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontFamily: 'Courier',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Seu QR-Code de identificação',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Courier',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              QrImage(
                data: qrData,
                size: (Get.width - 30),
                version: QrVersions.auto,
                gapless: false,
              ),

              /// LOG OUT BUTTON
              ElevatedButton(
                onPressed: () {
                  logout();
                },
                child: const Text("Sair"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void logout() {
    _storage.remove(StorageConstants.tokenAuthorization);
    Get.offAllNamed(Routes.login);
  }
}

*/
