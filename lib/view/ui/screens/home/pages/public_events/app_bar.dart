import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

class AppBarPublicEvents extends StatelessWidget {
  const AppBarPublicEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Todos eventos',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      leadingWidth: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.location_on,
          ),
        ).withPaddingOnly(right: 8)
      ],
    );
  }
}
