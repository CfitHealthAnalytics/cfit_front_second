import 'package:json_annotation/json_annotation.dart';

part 'user.data.g.dart';

@JsonSerializable()
class UserData {
  final int id;
  final String kind,
      localId,
      email,
      displayName,
      idToken,
      registered,
      refreshToken,
      expiresIn;

  UserData({
    required this.id,
    required this.kind,
    required this.localId,
    required this.email,
    this.displayName = '',
    required this.idToken,
    required this.registered,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
