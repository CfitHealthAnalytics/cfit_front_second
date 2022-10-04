import 'dart:convert';

import 'package:cfit/domain/models/user.dart';

class CompleteAccountArguments {
  final ConectaUser conectaUser;
  final int initialTab;

  CompleteAccountArguments({
    required this.conectaUser,
    required this.initialTab,
  });

  Map<String, dynamic> toMap() {
    return {
      'conectaUser': conectaUser.toMap(),
      'initialTab': initialTab,
    };
  }

  factory CompleteAccountArguments.fromMap(Map<String, dynamic> map) {
    return CompleteAccountArguments(
      conectaUser: ConectaUser.fromMap(map['conectaUser']),
      initialTab: map['initialTab']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompleteAccountArguments.fromJson(String source) =>
      CompleteAccountArguments.fromMap(json.decode(source));
}
