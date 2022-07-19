import 'package:cfit/constants.dart';
import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/widgets/EventsCity_item.dart';
import 'package:cfit/view/ui/screens/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EventsAcademyScreen extends GetView<EventsController> {
  final _storage = Get.find<GetStorage>();

  static Future<void> loadData(bool reload) async {
    Get.find<UserController>().getUserInfo();
    Get.find<EventsController>().getCityEventsList(reload, 'all', false);
  }

  final List<DateTime> events = [];

  @override
  Widget build(BuildContext context) {
    loadData(false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          EventsAcademyScreen.loadData(true);
        },
        child: GetBuilder<UserController>(builder: (userController) {
          return userController.userInfoModel.name == null
              ? Container(
                  margin: const EdgeInsets.all(0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                      strokeWidth: 5,
                      value: 3,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                    GetBuilder<EventsController>(builder: (eventController) {
                      //eventController.getEventsList(reload: false);
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top,
                                right: 25,
                                left: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Academia Recife',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          Get.toNamed(Routes.eventos_favorite),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 30, right: 10),
                                        transform: Matrix4.rotationZ(100),
                                        child: Stack(
                                          children: [
                                            const Icon(
                                              Icons.notifications_none_outlined,
                                              size: 30,
                                              color: Color(0xffffffff),
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: kPrimaryColor,
                              highlightColor: kAltTextColor,
                              disabledColor: Colors.green,
                            ),
                            child: AdvancedCalendar(
                              controller:
                                  eventController.calendarControllerToday,
                              events: events,
                              startWeekDay: 1,
                            ),
                          ),
                          //const SizedBox(height: 40),
                          eventController.eventosCity.isEmpty
                              ? eventController.eventosCity == null
                                  ? const SizedBox(
                                      width: 1,
                                    )
                                  : Container(
                                      margin: const EdgeInsets.all(0),
                                      child: Center(
                                        child: Loading(),
                                      ),
                                    )
                              : Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) =>
                                          EventsCityItem(
                                        job: eventController.eventosCity[index],
                                        eventC: eventController,
                                      ),
                                      separatorBuilder: (_, index) =>
                                          const SizedBox(
                                        height: 15,
                                      ),
                                      itemCount:
                                          eventController.eventosCity.length,
                                    ),
                                  ),

                                  //child: EventsList(controller: eventController),
                                ),
                        ],
                      );
                    }),
                  ],
                );
        }),
      ),
    );
  }
}
