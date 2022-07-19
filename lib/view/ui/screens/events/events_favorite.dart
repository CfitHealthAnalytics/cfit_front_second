import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/widgets/events_favorite_list.dart';
import 'package:flutter/material.dart';
import 'package:cfit/view/ui/screens/widgets/events_app_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EventsFavoriteScreen extends GetView<EventsController> {
  final _storage = Get.find<GetStorage>();

  static Future<void> loadData(bool reload) async {
    Get.find<EventsController>().getEventsFavoriteList(reload, 'all', false);
  }

  @override
  Widget build(BuildContext context) {
    //Future<EventsModels> eventos = Get.find<AuthController>().getCityEvents();
    //Get.find<AuthController>().getCityEvents();

    Get.find<EventsController>().getEventsFavoriteList(false, 'all', false);
    print('asd');
    loadData(false);

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
              /*
              FadeAnimation(
                delay: 2.5,
                child: const EventsOption(),
              ),
              */
              GetBuilder<EventsController>(builder: (eventController) {
                return Expanded(
                  child: EventsFavoriteList(controller: eventController),
                );
                //return eventController.events
                /*
                    return productController.events == null ? 
                        PopularFoodView(productController: productController, isPopular: true)
                        : 
                        productController.popularProductList.length == 0 ? 
                          SizedBox() : 
                          PopularFoodView(productController: productController, isPopular: true);
                          */
              })
            ],
          )
        ],
      ),
    );
  }
}
