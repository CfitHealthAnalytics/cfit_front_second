import 'package:cfit/domain/models/events.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class Feed {
  final User user;
  final List<Event> myEvents;
  final List<Event> gymCity;
  final List<Event> publicEvents;

  Feed({
    required this.user,
    required this.myEvents,
    required this.gymCity,
    required this.publicEvents,
  });

  List<Event> get all => [...myEvents, ...gymCity, ...publicEvents];

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
