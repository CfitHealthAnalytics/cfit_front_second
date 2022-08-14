import 'dart:convert';

import 'package:cfit/domain/models/events_city.dart';

class EventDetailsArguments {
  final EventCity eventCity;
  EventDetailsArguments({
    required this.eventCity,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_city': eventCity.toMap(),
    };
  }

  factory EventDetailsArguments.fromMap(Map<String, dynamic> map) {
    return EventDetailsArguments(
      eventCity: EventCity.fromMap(map['event_city']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDetailsArguments.fromJson(String source) =>
      EventDetailsArguments.fromMap(json.decode(source));
}
