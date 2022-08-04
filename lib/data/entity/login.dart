import 'dart:convert';

class LoginBodyRequest {
  final String email;
  final String password;

  LoginBodyRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginBodyRequest.fromMap(Map<String, dynamic> map) {
    return LoginBodyRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginBodyRequest.fromJson(String source) =>
      LoginBodyRequest.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginBodyRequest &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

class LoginBodyResponse {
  final String localId;
  final String email;
  final String displayName;
  final String idToken;
  final bool registered;
  final String refreshToken;
  final String expiresIn;

  LoginBodyResponse({
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
    required this.refreshToken,
    required this.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'email': email,
      'displayName': displayName,
      'idToken': idToken,
      'registered': registered,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory LoginBodyResponse.fromMap(Map<String, dynamic> map) {
    return LoginBodyResponse(
      localId: map['localId'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      idToken: map['idToken'] ?? '',
      registered: map['registered'] ?? false,
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginBodyResponse.fromJson(String source) =>
      LoginBodyResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginBodyResponse &&
        other.localId == localId &&
        other.email == email &&
        other.displayName == displayName &&
        other.idToken == idToken &&
        other.registered == registered &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        idToken.hashCode ^
        registered.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode;
  }
}
