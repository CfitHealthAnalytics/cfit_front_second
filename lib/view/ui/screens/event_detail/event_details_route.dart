import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_details_cubit.dart';
import 'event_details_navigation.dart';
import 'event_details_screen.dart';

class EventDetailsRoute extends StatelessWidget {
  const EventDetailsRoute({
    Key? key,
    required this.eventCity,
  }) : super(key: key);
  final EventCity eventCity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailsCubit(
        EventDetailsNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.scheduleEventsInCityUseCase(),
      ),
      child: EventDetailsScreen(
        eventCity: eventCity,
      ),
    );
  }
}