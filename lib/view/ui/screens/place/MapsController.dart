import 'dart:async';

import 'package:cfit/presentation/shared/loading/loading.controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends GetxController {
  final _loadingController = Get.find<LoadingController>();

//class MapsController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  final Completer<GoogleMapController> google = Completer();

  @override
  void dispose() {
    Get.delete<MapsController>();
    super.dispose();
  }
}
