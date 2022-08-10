import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/ui/screens/home/pages/profile/body.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'pages/dashboard/app_bar.dart';
import 'pages/profile/app_bar.dart';

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
        return HomeLoaded(
          user: user,
          qrData: controller.qrData,
        );
      },
    );
  }
}

class HomeLoaded extends StatefulWidget {
  const HomeLoaded({
    Key? key,
    required this.user,
    required this.qrData,
  }) : super(key: key);

  final User user;
  final String qrData;

  @override
  State<HomeLoaded> createState() => _HomeLoadedState();
}

class _HomeLoadedState extends State<HomeLoaded> {
  int currentIndex = 0;

  HomeLoadedContent buildContent() {
    switch (currentIndex) {
      case 0:
        return HomeLoadedContent(
          body: Container(),
          appBar: PreferredSize(
            child: AppBarDashboard(user: widget.user),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
      case 1:
        return HomeLoadedContent(
          body: BodyProfile(
            user: widget.user,
            qrData: widget.qrData,
          ),
          appBar: PreferredSize(
            child: const AppBarProfile(),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
      default:
        return HomeLoadedContent(
          body: Container(),
          appBar: PreferredSize(
            child: AppBarDashboard(user: widget.user),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = buildContent();
    return Scaffold(
      appBar: content.appBar,
      body: content.body,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ],
        elevation: 10,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}

class HomeLoadedContent {
  final PreferredSize? appBar;
  final Widget body;

  HomeLoadedContent({
    this.appBar,
    required this.body,
  });
}
