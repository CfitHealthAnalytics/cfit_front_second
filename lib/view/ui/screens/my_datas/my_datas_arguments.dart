import 'dart:convert';

import 'package:cfit/domain/models/user.dart';

class MyDataArguments {
  final User user;
  MyDataArguments({
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
    };
  }

  factory MyDataArguments.fromMap(Map<String, dynamic> map) {
    return MyDataArguments(
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyDataArguments.fromJson(String source) =>
      MyDataArguments.fromMap(json.decode(source));
}
