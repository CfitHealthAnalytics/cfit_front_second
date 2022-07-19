import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/helper/route_helper.dart';
import 'package:cfit/util/dimensions.dart';
import 'package:cfit/util/images.dart';
import 'package:cfit/util/styles.dart';
import 'package:cfit/view/ui/screens/maps/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cfit/view/base/text_hover.dart';

class WebMenuBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<WebMenuBar> createState() => _WebMenuBarState();

  @override
  Size get preferredSize => const Size(Dimensions.WEB_MAX_WIDTH, 70);
}

class _WebMenuBarState extends State<WebMenuBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH,
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Center(
          child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Row(children: [
                InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
                  child: Image.asset(Images.logo, width: 100),
                ),
                Get.find<LocationController>().getUserAddress() != null
                    ? Expanded(
                        child: InkWell(
                        onTap: () => Get.toNamed(
                            RouteHelper.getAccessLocationRoute('home')),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: GetBuilder<LocationController>(
                              builder: (locationController) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  locationController
                                              .getUserAddress()
                                              .addressType ==
                                          'home'
                                      ? Icons.home_filled
                                      : locationController
                                                  .getUserAddress()
                                                  .addressType ==
                                              'office'
                                          ? Icons.work
                                          : Icons.location_on,
                                  size: 20,
                                  color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color ??
                                      const Color(0xff000000),
                                ),
                                const SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                /*Flexible(
                                  child: Text(
                                    locationController.getUserAddress().address,
                                    style: robotoRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                */
                                Icon(Icons.keyboard_arrow_down,
                                    color: Theme.of(context).primaryColor),
                              ],
                            );
                          }),
                        ),
                      ))
                    : const Expanded(child: SizedBox()),
                const SizedBox(width: 20),
                /*
                Get.find<LocationController>().getUserAddress() == null
                    ? Row(children: [
                        MenuButton(
                            title: 'home'.tr,
                            onTap: () =>
                                Get.toNamed(RouteHelper.getInitialRoute())),
                        const SizedBox(width: 20),
                        MenuButton(
                            title: 'about_us'.tr,
                            onTap: () => Get.toNamed(
                                RouteHelper.getHtmlRoute('about-us'))),
                        const SizedBox(width: 20),
                        MenuButton(
                            title: 'privacy_policy'.tr,
                            onTap: () => Get.toNamed(
                                RouteHelper.getHtmlRoute('privacy-policy'))),
                      ])
                    : SizedBox(
                        width: 250,
                        child: GetBuilder<SearchController>(
                            builder: (searchController) {
                          _searchController.text =
                              searchController.searchHomeText;
                          return SearchField(
                            controller: _searchController,
                            hint: Get.find<SplashController>()
                                    .configModel
                                    .moduleConfig
                                    .module
                                    .showRestaurantText
                                ? 'search_food_or_restaurant'.tr
                                : 'search_item_or_store'.tr,
                            suffixIcon:
                                searchController.searchHomeText.length > 0
                                    ? Icons.highlight_remove
                                    : Icons.search,
                            filledColor: Theme.of(context).backgroundColor,
                            iconPressed: () {
                              if (searchController.searchHomeText.length > 0) {
                                _searchController.text = '';
                                searchController.clearSearchHomeText();
                              } else {
                                searchData();
                              }
                            },
                            onSubmit: (text) => searchData(),
                          );
                        })),
                        
                const SizedBox(width: 20),
                
                MenuIconButton(
                    icon: Icons.notifications,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getNotificationRoute())),
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.favorite,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getMainRoute('favourite'))),
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.shopping_cart,
                    isCart: true,
                    onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
                const SizedBox(width: 20),
                GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                  int _index = 0;
                  List<DropdownMenuItem<int>> _languageList = [];
                  for (int index = 0;
                      index < AppConstants.languages.length;
                      index++) {
                    _languageList.add(DropdownMenuItem(
                      child: TextHover(builder: (hovered) {
                        return Row(children: [
                          Image.asset(AppConstants.languages[index].imageUrl,
                              height: 20, width: 20),
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Text(AppConstants.languages[index].languageName,
                              style: robotoRegular.copyWith(
                                  color: hovered
                                      ? Theme.of(context).primaryColor
                                      : null)),
                        ]);
                      }),
                      value: index,
                    ));
                    if (AppConstants.languages[index].languageCode ==
                        localizationController.locale.languageCode) {
                      _index = index;
                    }
                  }
                  return DropdownButton<int>(
                    value: _index,
                    items: _languageList,
                    dropdownColor: Theme.of(context).cardColor,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 0,
                    iconSize: 30,
                    underline: const SizedBox(),
                    onChanged: (int index) {
                      localizationController.setLanguage(Locale(
                          AppConstants.languages[index].languageCode,
                          AppConstants.languages[index].countryCode));
                    },
                  );
                }),
                */
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.menu,
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    }),
                const SizedBox(width: 20),
                GetBuilder<AuthController>(builder: (authController) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(authController.isLoggedIn()
                          ? RouteHelper.getProfileRoute()
                          : RouteHelper.getSignInRoute(RouteHelper.main));
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Row(children: [
                        Icon(
                            authController.isLoggedIn()
                                ? Icons.person_pin_rounded
                                : Icons.lock,
                            size: 20,
                            color: Colors.white),
                        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Text(
                            authController.isLoggedIn()
                                ? 'profile'.tr
                                : 'sign_in'.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Colors.white)),
                      ]),
                    ),
                  );
                }),
              ]))),
    );
  }

  void searchData() {
    if (_searchController.text.trim().isEmpty) {
      /*
      showCustomSnackBar(Get.find<SplashController>()
              .configModel
              .moduleConfig
              .module
              .showRestaurantText
          ? 'search_food_or_restaurant'.tr
          : 'search_item_or_store'.tr);
          */
    } else {
      /*
      Get.toNamed(
          RouteHelper.getSearchRoute(queryText: _searchController.text.trim()));
          */
    }
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const MenuButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        onTap: onTap,
        child: Text(title,
            style: robotoRegular.copyWith(
                color: hovered ? Theme.of(context).primaryColor : null)),
      );
    });
  }
}

class MenuIconButton extends StatelessWidget {
  final IconData icon;
  final bool isCart;
  final Function() onTap;
  const MenuIconButton(
      {required this.icon, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: hovered
              ? Theme.of(context).primaryColor
              : Theme.of(context).textTheme.bodyText1?.color ??
                  const Color(0xff000000),
        ),

        /*
        GetBuilder<CartController>(builder: (cartController) {
          return Stack(clipBehavior: Clip.none, children: [
            Icon(
              icon,
              color: hovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyText1?.color ??
                      const Color(0xff000000),
            ),
            (isCart && cartController.cartList.length > 0)
                ? Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      height: 15,
                      width: 15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        cartController.cartList.length.toString(),
                      ),
                    ),
                  )
                : const SizedBox()
          ]);
        }),
        */
      );
    });
  }
}