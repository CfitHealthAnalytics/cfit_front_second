import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem extends StatelessWidget {
  //final IconData iconData;
  final String iconData;
  final Function()? onTap;
  final bool isSelected;
  const BottomNavItem(
      {required this.iconData, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    //print(isSelected);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          iconData,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          matchTextDirection: true,
        ),
      ),
      //Image.asset(iconData, width: 40),
      //const Text('Test'),

      /*IconButton(
        icon: Icon(iconData,
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            size: 25),
        onPressed: onTap,
      ),*/
    );
  }
}
