import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_city_detail_cubit.dart';
import 'event_city_detail_navigation.dart';
import 'event_city_detail_screen.dart';

class EventCityDetailsRoute extends StatelessWidget {
  const EventCityDetailsRoute({
    Key? key,
    required this.eventCity,
    required this.user,
    required this.alreadyScheduled,
  }) : super(key: key);
  final EventCity eventCity;
  final User user;
  final bool alreadyScheduled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCityDetailsCubit(
        EventCityDetailsNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.scheduleEventsInCityUseCase(),
        alreadyScheduled: alreadyScheduled,
      ),
      child: EventCityDetailsScreen(eventCity: eventCity, user: user),
    );
  }
}
