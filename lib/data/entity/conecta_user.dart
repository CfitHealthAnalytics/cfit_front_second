import 'dart:convert';

class AddConectaUserRequest {
  final String hash;
  final String email;

  AddConectaUserRequest({
    required this.hash,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
      'email': email,
    };
  }

  factory AddConectaUserRequest.fromMap(Map<String, dynamic> map) {
    return AddConectaUserRequest(
      hash: map['hash'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddConectaUserRequest.fromJson(String source) =>
      AddConectaUserRequest.fromMap(json.decode(source));
}

class ConectaUserInfoResponse {
  final String sub;
  final bool emailVerified;
  final int securityLevel;
  final String name;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String userType;
  final String email;

  ConectaUserInfoResponse({
    required this.sub,
    required this.emailVerified,
    required this.securityLevel,
    required this.name,
    required this.preferredUsername,
    required this.givenName,
    required this.familyName,
    required this.userType,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'sub': sub,
      'emailVerified': emailVerified,
      'securityLevel': securityLevel,
      'name': name,
      'preferredUsername': preferredUsername,
      'givenName': givenName,
      'familyName': familyName,
      'userType': userType,
      'email': email,
    };
  }

  factory ConectaUserInfoResponse.fromMap(Map<String, dynamic> map) {
    return ConectaUserInfoResponse(
      sub: map['sub'] ?? '',
      emailVerified: map['email_verified'] ?? false,
      securityLevel: map['nivel_seguranca']?.toInt() ?? 0,
      name: map['name'] ?? '',
      preferredUsername: map['preferred_username'] ?? '',
      givenName: map['given_name'] ?? '',
      familyName: map['family_name'] ?? '',
      userType: map['tipo_usuario'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConectaUserInfoResponse.fromJson(String source) =>
      ConectaUserInfoResponse.fromMap(json.decode(source));
}
