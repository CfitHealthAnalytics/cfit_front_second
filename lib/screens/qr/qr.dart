import 'package:cfit/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {

  String qrData="https://perfil.com/conta/max";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [

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
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              'Gabriela Veras',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Courier',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 10,
            ),

            Text(
              'Seu QR-Code de identificação',

              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Courier',
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),

            QrImage(data: qrData,size: 200.0,),

          ],
        ),
      ),
    );
  }
}