import 'dart:convert';

class UserBodyRequest {
  final String idToken;
  UserBodyRequest({
    required this.idToken,
  });

  UserBodyRequest copyWith({
    String? idToken,
  }) {
    return UserBodyRequest(
      idToken: idToken ?? this.idToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idtoken': idToken,
    };
  }

  factory UserBodyRequest.fromMap(Map<String, dynamic> map) {
    return UserBodyRequest(
      idToken: map['idToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBodyRequest.fromJson(String source) =>
      UserBodyRequest.fromMap(json.decode(source));

  @override
  String toString() => 'UserBodyRequest(idToken: $idToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBodyRequest && other.idToken == idToken;
  }

  @override
  int get hashCode => idToken.hashCode;
}

class UserBodyResponse {
  final String name;
  final String dateBirth;
  final String gender;
  final String email;

  UserBodyResponse({
    required this.name,
    required this.dateBirth,
    required this.gender,
    required this.email,
  });

  UserBodyResponse copyWith({
    String? name,
    String? dateBirth,
    String? gender,
    String? email,
  }) {
    return UserBodyResponse(
      name: name ?? this.name,
      dateBirth: dateBirth ?? this.dateBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateBirth': dateBirth,
      'gender': gender,
      'email': email,
    };
  }

  factory UserBodyResponse.fromMap(Map<String, dynamic> map) {
    return UserBodyResponse(
      name: map['name'] ?? '',
      dateBirth: map['data_nascimento'] ?? '',
      gender: map['genero'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBodyResponse.fromJson(String source) =>
      UserBodyResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBodyResponse(name: $name, dateBirth: $dateBirth, gender: $gender, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBodyResponse &&
        other.name == name &&
        other.dateBirth == dateBirth &&
        other.gender == gender &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dateBirth.hashCode ^
        gender.hashCode ^
        email.hashCode;
  }
}
