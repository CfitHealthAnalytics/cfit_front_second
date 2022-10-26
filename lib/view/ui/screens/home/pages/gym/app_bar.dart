import 'package:flutter/material.dart';

class AppBarGym extends StatelessWidget {
  const AppBarGym({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Polo Macaxeira',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
    );
  }
}
