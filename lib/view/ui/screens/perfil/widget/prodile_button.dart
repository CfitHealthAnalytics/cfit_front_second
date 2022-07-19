import 'package:cfit/util/dimensions.dart';
import 'package:cfit/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isButtonActive;
  final Function() onTap;
  const ProfileButton({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isButtonActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: isButtonActive != null
              ? Dimensions.PADDING_SIZE_EXTRA_SMALL
              : Dimensions.PADDING_SIZE_DEFAULT,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 158, 158, 158),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Row(children: [
          Icon(icon, size: 25),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(child: Text(title, style: robotoRegular)),
          isButtonActive != null
              ? Switch(
                  value: isButtonActive,
                  onChanged: (bool isActive) => onTap(),
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
