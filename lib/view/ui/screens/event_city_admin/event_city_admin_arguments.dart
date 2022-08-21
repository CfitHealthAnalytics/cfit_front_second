import 'dart:convert';

import 'package:cfit/domain/models/events_city.dart';

class EventCityAdminArguments {
  EventCityAdminArguments({
    required this.eventCity,
  });
  final EventCity eventCity;

  Map<String, dynamic> toMap() {
    return {
      'event_city': eventCity.toMap(),
    };
  }

  factory EventCityAdminArguments.fromMap(Map<String, dynamic> map) {
    return EventCityAdminArguments(
      eventCity: EventCity.fromMap(map['event_city']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventCityAdminArguments.fromJson(String source) =>
      EventCityAdminArguments.fromMap(json.decode(source));
}
