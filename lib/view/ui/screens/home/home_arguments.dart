import 'dart:convert';

import 'package:cfit/domain/models/user.dart';

class HomeArguments {
  final User? user;
  final int? initialTab;

  HomeArguments({
    this.user,
    this.initialTab,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'initialTab': initialTab,
    };
  }

  factory HomeArguments.fromMap(Map<String, dynamic> map) {
    return HomeArguments(
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      initialTab: map['initialTab']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeArguments.fromJson(String source) =>
      HomeArguments.fromMap(json.decode(source));
}
