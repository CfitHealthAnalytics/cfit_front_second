import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class Feed {
  final User user;
  final List<EventCity> myEvents;
  final List<EventCity> gymCity;
  final List<EventCity> publicEvents;

  Feed({
    required this.user,
    required this.myEvents,
    required this.gymCity,
    required this.publicEvents,
  });

  List<EventCity> get all => [...myEvents, ...gymCity, ...publicEvents];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feed &&
        other.user == user &&
        listEquals(other.myEvents, myEvents) &&
        listEquals(other.gymCity, gymCity) &&
        listEquals(other.publicEvents, publicEvents);
  }

  @override
  int get hashCode {
    return user.hashCode ^
        myEvents.hashCode ^
        gymCity.hashCode ^
        publicEvents.hashCode;
  }
}
