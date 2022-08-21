import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_city_admin_cubit.dart';
import 'event_city_admin_navigation.dart';
import 'event_city_admin_screen.dart';

class EventCityAdminRoute extends StatelessWidget {
  const EventCityAdminRoute({
    Key? key,
    required this.eventCity,
  }) : super(key: key);
  final EventCity eventCity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCityAdminCubit(
          EventCityAdminNavigation.fromMaterialNavigation(
            Navigator.of(context),
          ),
          context.confirmationEventInCityUseCase()),
      child: EventCityAdminScreen(
        eventCity: eventCity,
      ),
    );
  }
}
