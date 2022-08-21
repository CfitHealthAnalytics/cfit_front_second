import 'package:cfit/domain/models/events_city.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_event_cubit.dart';
import 'my_event_navigation.dart';
import 'my_event_screen.dart';

class MyEventRoute extends StatelessWidget {
  const MyEventRoute({
    Key? key,
    required this.eventCity,
  }) : super(key: key);
  final EventCity eventCity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyEventCubit(
        MyEventNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
      ),
      child: MyEventScreen(
        eventCity: eventCity,
      ),
    );
  }
}
