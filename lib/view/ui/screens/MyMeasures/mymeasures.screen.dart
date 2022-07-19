import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/MyMeasures/controllers/mymeasures.controller.dart';
import 'package:cfit/view/ui/screens/widgets/events_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//

import 'package:get_storage/get_storage.dart';

import 'package:cfit/view/ui/screens/widgets/chart_workout_progress.dart';
import 'package:fl_chart/fl_chart.dart';

//import 'package:connectivity/connectivity.dart';

class MyMeasuresScreen extends GetView<MyMeasuresController> {
  final _storage = Get.find<GetStorage>();

  @override
  Widget build(BuildContext context) {
    String qrData = "CFjzbLMGuoiaXsd7oMpBH3O7tXSv7221111997M";
    //Future<EventsModels> eventos = Get.find<AuthController>().getCityEvents();
    //Future<dynamic> eventos = Get.find<AuthController>().getCityEvents();
    //Get.find<AuthController>().getCityEvents();

    var size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      /// Body
      body: SizedBox(
        //margin: const EdgeInsets.all(17),
        width: w,
        height: h,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  const Text(
                    'Suas medidas',
                    style: TextStyle(
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
                    "Peso x Meta",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black.withOpacity(0.01),
                              spreadRadius: 20,
                              blurRadius: 10,
                              offset: const Offset(0, 10))
                        ],
                        borderRadius: BorderRadius.circular(30)),
                    child: LineChart(
                      workoutProgressData(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Data da última avaliação: 20/02/2022",
                    style: TextStyle(fontSize: 18, color: black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 52,
                      ),
                      Text(
                        '18,6 kg/m2',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Text(
                        '18,6 kg/m2',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 82,
                      ),
                      Text(
                        'IMC',
                        style: TextStyle(fontSize: 18, color: black),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Text(
                        'Peso',
                        style: TextStyle(fontSize: 18, color: black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 72,
                      ),
                      Text(
                        '23%',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizedBox(
                        width: 143,
                      ),
                      Text(
                        '120/70',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Gordura Corporal',
                        style: TextStyle(fontSize: 18, color: black),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        'Pressão Anterial',
                        style: TextStyle(fontSize: 18, color: black),
                      ),
                    ],
                  ),

                  /*
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Container(
                            width: (size.width - 70),
                            height: 150,
                            decoration: BoxDecoration(
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      color: black.withOpacity(0.01),
                                      spreadRadius: 20,
                                      blurRadius: 10,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sleep",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    child: LineChart(sleepData()),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
