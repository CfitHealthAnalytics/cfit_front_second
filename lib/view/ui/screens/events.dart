import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:flutter/material.dart';
import 'package:cfit/view/ui/screens/widgets/events_app_bar.dart';
import 'package:cfit/view/ui/screens/widgets/events_list.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EventsScreen extends GetView<EventsController> {
  final _storage = Get.find<GetStorage>();

  static Future<void> loadData(bool reload) async {
    Get.find<EventsController>().getEventsList(reload: true);
  }

  @override
  Widget build(BuildContext context) {
    //Future<EventsModels> eventos = Get.find<AuthController>().getCityEvents();
    //Get.find<AuthController>().getCityEvents();

    //loadData(false);

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
                  child: EventsList(controller: eventController),
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
