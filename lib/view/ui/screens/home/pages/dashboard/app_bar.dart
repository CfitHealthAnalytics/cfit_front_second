import 'package:cfit/domain/models/user.dart';
import 'package:flutter/material.dart';

class AppBarDashboard extends StatelessWidget {
  const AppBarDashboard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bem-vindo, ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          Text(
            user.name.nameImprovident(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 0,
    );
  }
}

extension on String {
  String nameImprovident() {
    if (split(' ').length > 1) {
      final splinted = split(' ');
      return '${splinted.first} ${splinted.last}';
    }

    return this;
  }
}
