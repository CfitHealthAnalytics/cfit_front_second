import 'dart:convert';

class RegisterBodyRequest {
  final String email;
  final String name;
  final String password;
  final String dateBirth;
  final String genre;

  RegisterBodyRequest({
    required this.email,
    required this.name,
    required this.password,
    required this.dateBirth,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': name,
      'password': password,
      'data_nascimento': dateBirth,
      'genero': genre,
    };
  }

  factory RegisterBodyRequest.fromMap(Map<String, dynamic> map) {
    return RegisterBodyRequest(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      dateBirth: map['dateBirth'] ?? '',
      genre: map['genre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterBodyRequest.fromJson(String source) =>
      RegisterBodyRequest.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterBodyRequest &&
        other.email == email &&
        other.name == name &&
        other.password == password &&
        other.dateBirth == dateBirth &&
        other.genre == genre;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        password.hashCode ^
        dateBirth.hashCode ^
        genre.hashCode;
  }
}

class RegisterBodyResponse {
  final String localId;
  final String email;
  final String displayName;
  final String idToken;
  final bool registered;
  final String refreshToken;
  final String expiresIn;

  RegisterBodyResponse({
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

  factory RegisterBodyResponse.fromMap(Map<String, dynamic> map) {
    return RegisterBodyResponse(
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

  factory RegisterBodyResponse.fromJson(String source) =>
      RegisterBodyResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterBodyResponse &&
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
