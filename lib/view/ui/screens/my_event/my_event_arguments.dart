import 'dart:convert';

import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';

class MyEventArguments {
  MyEventArguments({
    required this.eventPublic,
    required this.user,
  });
  final EventPublic eventPublic;
  final User user;

  Map<String, dynamic> toMap() {
    return {
      'eventPublic': eventPublic.toMap(),
      'user': user.toMap(),
    };
  }

  factory MyEventArguments.fromMap(Map<String, dynamic> map) {
    return MyEventArguments(
      eventPublic: EventPublic.fromMap(map['eventPublic']),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyEventArguments.fromJson(String source) =>
      MyEventArguments.fromMap(json.decode(source));
}
