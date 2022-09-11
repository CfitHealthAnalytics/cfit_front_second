import 'dart:convert';

import 'package:cfit/domain/models/events_public.dart';

class CreatePublicEventsArguments {
  final EventPublic event;
  final bool isEdit;

  CreatePublicEventsArguments({
    required this.event,
    required this.isEdit,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event.toMap(),
      'isEdit': isEdit,
    };
  }

  factory CreatePublicEventsArguments.fromMap(Map<String, dynamic> map) {
    return CreatePublicEventsArguments(
      event: EventPublic.fromMap(map['event']),
      isEdit: map['isEdit'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePublicEventsArguments.fromJson(String source) =>
      CreatePublicEventsArguments.fromMap(json.decode(source));
}
