import 'dart:convert';

import 'package:cfit/domain/models/events_city.dart';

class MyEventArguments {
  MyEventArguments({
    required this.eventCity,
  });
  final EventCity eventCity;

  Map<String, dynamic> toMap() {
    return {
      'event_city': eventCity.toMap(),
    };
  }

  factory MyEventArguments.fromMap(Map<String, dynamic> map) {
    return MyEventArguments(
      eventCity: EventCity.fromMap(map['event_city']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyEventArguments.fromJson(String source) =>
      MyEventArguments.fromMap(json.decode(source));
}
