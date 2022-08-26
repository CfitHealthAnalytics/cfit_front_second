import 'dart:convert';

import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';

class EventPublicDetailsArguments {
  EventPublicDetailsArguments({
    required this.eventPublic,
    required this.user,
    required this.alreadyConfirmed,
  });
  final EventPublic eventPublic;
  final User user;
  final bool alreadyConfirmed;

  Map<String, dynamic> toMap() {
    return {
      'event_public': eventPublic.toMap(),
      'user': user.toMap(),
      'already_confirmed': alreadyConfirmed,
    };
  }

  factory EventPublicDetailsArguments.fromMap(Map<String, dynamic> map) {
    return EventPublicDetailsArguments(
      eventPublic: EventPublic.fromMap(map['event_public']),
      user: User.fromMap(map['user']),
      alreadyConfirmed: map['already_confirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventPublicDetailsArguments.fromJson(String source) =>
      EventPublicDetailsArguments.fromMap(json.decode(source));
}
