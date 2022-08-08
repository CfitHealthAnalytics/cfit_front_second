import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Feed?>(
      future: controller.init(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const LoadingBox(
                height: 20,
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16,
                  ),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: LoadingBox(
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        final user = snapshot.data!.user;
        return Scaffold(
          appBar: AppBar(
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
                  user.name,
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
