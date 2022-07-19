import 'package:flutter/material.dart';

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  const ProfileBgWidget(
      {required this.mainWidget,
      required this.circularImage,
      required this.backButton});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 60),
      Expanded(
        child: mainWidget,
      ),
    ]);
  }
}
