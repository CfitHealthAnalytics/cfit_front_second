import 'dart:convert';

import 'package:cfit/domain/models/user.dart';

class SelectLocalizationArguments {
  SelectLocalizationArguments({
    required this.toCreateEvent,
    required this.user,
  });
  final bool toCreateEvent;
  final User user;

  Map<String, dynamic> toMap() {
    return {
      'toCreateEvent': toCreateEvent,
      'user': user.toMap(),
    };
  }

  factory SelectLocalizationArguments.fromMap(Map<String, dynamic> map) {
    return SelectLocalizationArguments(
      toCreateEvent: map['toCreateEvent'] ?? false,
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectLocalizationArguments.fromJson(String source) =>
      SelectLocalizationArguments.fromMap(json.decode(source));
}
