import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoupapAlert extends StatelessWidget {
  final double height;
  final double width;
  const PoupapAlert({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: kPrimaryColor,
      child: SizedBox(
        height: height * 0.38,
        width: width * 0.42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Confirmar Presença',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRaisedBtn(
                    onPressed: () {
                      Get.back();
                    },
                    borderRadius: 18,
                    width: width * 0.15,
                    height: 32,
                    child: const Text(
                      'Voltar',
                    ),
                    color: Colors.white),
                CustomRaisedBtn(
                    onPressed: () {
                      Get.back();
                    },
                    borderRadius: 18,
                    width: width * 0.15,
                    height: 32,
                    child: const Text(
                      'Não',
                    ),
                    color: Colors.red),
                CustomRaisedBtn(
                    onPressed: () {
                      print('Confirmado');
                      //SharedPreferenceHelper.clearSharedPreferenceOnLogOut();
                      Get.back();
                      //Get.offNamed('/login');
                    },
                    borderRadius: 18,
                    width: width * 0.15,
                    height: 32,
                    child: const Text(
                      'Sim',
                    ),
                    color: kPrimaryBottom),
              ],
            )
          ],
        ),
      ),
    );
  }
}
