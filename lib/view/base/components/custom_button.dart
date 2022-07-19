import 'package:flutter/material.dart';
import 'package:cfit/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.tap,
    required this.text,
    this.backgroundBottom = kPrimaryBottom,
    this.CorBottom = kBackgroundWhite,
  }) : super(key: key);

  final GestureTapCallback tap;
  final String text;
  final Color? backgroundBottom;
  final Color? CorBottom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: backgroundBottom,
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            backgroundColor: kBackgroundColor,
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
