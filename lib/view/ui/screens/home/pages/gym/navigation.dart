import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/event_detail/event_details_arguments.dart';
import 'package:flutter/material.dart';

class GymNavigation {
  final void Function(EventCity event) toEventDetail;

  GymNavigation({
    required this.toEventDetail,
  });

  factory GymNavigation.fromMaterialNavigator(NavigatorState navigator) {
    return GymNavigation(
      toEventDetail: (EventCity event) => navigator.pushNamed(
        Routes.event_details,
        arguments: EventDetailsArguments.fromMap({
          'event_city': event.toMap(),
        }).toJson(),
      ),
    );
  }
}
