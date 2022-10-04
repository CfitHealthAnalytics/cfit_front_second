import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:cfit/view/ui/screens/home/pages/dashboard/body.dart';
import 'package:cfit/view/ui/screens/home/pages/gym/app_bar.dart';
import 'package:cfit/view/ui/screens/home/pages/profile/body.dart';
import 'package:cfit/view/ui/screens/home/pages/public_events/app_bar.dart';
import 'package:cfit/view/ui/screens/home/pages/public_events/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'home_cubit.dart';
import 'pages/dashboard/app_bar.dart';
import 'pages/gym/body.dart';
import 'pages/profile/app_bar.dart';
import 'pages/profile/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final cubit = context.read<HomeCubit>();
    cubit.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loadingRequestInit) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LoadingBox(
                    height: 20,
                    customWidth: 50,
                  ),
                  SizedBox(height: 10),
                  LoadingBox(
                    height: 20,
                  ),
                ],
              ),
              centerTitle: true,
              leadingWidth: 0,
            ),
          );
        }
        if (state.feed == null) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        '''Infelizmente não conseguimos buscar suas informações. Mas tente novamente mais tarde''',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return HomeLoaded(
          navigation: cubit.navigation,
          initialTab: cubit.initialTab,
        );
      },
    );
  }
}

class HomeLoaded extends StatefulWidget {
  const HomeLoaded({
    Key? key,
    required this.navigation,
    required this.initialTab,
  }) : super(key: key);

  final HomeNavigation navigation;
  final int initialTab;

  @override
  State<HomeLoaded> createState() => _HomeLoadedState();
}

class _HomeLoadedState extends State<HomeLoaded> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = widget.initialTab;
    super.initState();
  }

  @override
  void dispose() {
    final cubit = context.read<HomeCubit>();
    cubit.setNotAlreadyLoaded();
    super.dispose();
  }

  HomeLoadedContent buildContent(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    switch (currentIndex) {
      case 0:
        return HomeLoadedContent(
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return VisibilityDetector(
                key: const Key('body-dashboard'),
                onVisibilityChanged: (visibility) {
                  if (visibility.visibleFraction > 0 && !cubit.alreadyLoaded) {
                    cubit.setAlreadyLoaded();
                    cubit.getConfirmedEvent();
                  } else {
                    cubit.setNotAlreadyLoaded();
                  }
                },
                child: BodyDashboard(
                  navigation: widget.navigation,
                ),
              );
            },
          ),
          appBar: PreferredSize(
            child: AppBarDashboard(user: cubit.user!),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
      case 1:
        return HomeLoadedContent(
          body: BodyGym(
            user: cubit.user!,
            getEventsCity: cubit.getEventsCity,
            navigation: widget.navigation,
          ),
          appBar: PreferredSize(
            child: const AppBarGym(),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
      case 2:
        return HomeLoadedContent(
          body: BodyPublicEvents(
            getEventsPublic: cubit.getEventsPublic,
            getAddress: () async {
              final response = await cubit.getAddress();
              return response?.address;
            },
            user: cubit.user!,
          ),
          appBar: PreferredSize(
            child: const AppBarPublicEvents(),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              60,
            ),
          ),
        );
      case 3:
        return HomeLoadedContent(
          body: BodyProfile(
            user: cubit.user!,
            qrData: cubit.qrData!,
            navigation: ProfileNavigation.fromMaterialNavigator(
              Navigator.of(context),
            ),
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
            child: AppBarDashboard(user: cubit.user!),
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
    final content = buildContent(context);
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
            icon: Icon(Icons.fitness_center),
            label: 'Academia Recife',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Eventos',
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
