import 'dart:convert';

import 'package:cfit/domain/models/events_city.dart';

class EventDetailsArguments {
  EventDetailsArguments({
    required this.eventCity,
    required this.alreadyConfirmed,
  });
  final EventCity eventCity;
  final bool alreadyConfirmed;

  Map<String, dynamic> toMap() {
    return {
      'event_city': eventCity.toMap(),
      'already_confirmed': alreadyConfirmed,
    };
  }

  factory EventDetailsArguments.fromMap(Map<String, dynamic> map) {
    return EventDetailsArguments(
      eventCity: EventCity.fromMap(map['event_city']),
      alreadyConfirmed: map['already_confirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDetailsArguments.fromJson(String source) =>
      EventDetailsArguments.fromMap(json.decode(source));
}
