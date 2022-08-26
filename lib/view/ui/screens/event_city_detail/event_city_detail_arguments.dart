import 'dart:convert';

import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';

class EventCityDetailsArguments {
  EventCityDetailsArguments({
    required this.eventCity,
    required this.user,
    required this.alreadyConfirmed,
  });
  final EventCity eventCity;
  final User user;
  final bool alreadyConfirmed;

  Map<String, dynamic> toMap() {
    return {
      'event_city': eventCity.toMap(),
      'user': user.toMap(),
      'already_confirmed': alreadyConfirmed,
    };
  }

  factory EventCityDetailsArguments.fromMap(Map<String, dynamic> map) {
    return EventCityDetailsArguments(
      eventCity: EventCity.fromMap(map['event_city']),
      user: User.fromMap(map['user']),
      alreadyConfirmed: map['already_confirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventCityDetailsArguments.fromJson(String source) =>
      EventCityDetailsArguments.fromMap(json.decode(source));
}
