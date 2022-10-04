import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String dateBirth;
  final UserGender gender;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.dateBirth,
    required this.gender,
    this.isAdmin = false,
  });

  factory User.empty() {
    return User(
      id: '',
      name: '',
      email: '',
      dateBirth: '',
      gender: UserGender.male,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'dateBirth': dateBirth,
      'gender': gender.toStringRepresentation(),
      'is_admin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      dateBirth: map['dateBirth'] ?? '',
      gender: (map['gender'] as String).toGender(),
      isAdmin: map['is_admin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

enum UserGender { male, female }

extension GenderStringRepresentation on UserGender {
  String toStringRepresentation() {
    switch (this) {
      case UserGender.male:
        return 'masculino';

      case UserGender.female:
        return 'feminino';
    }
  }

  String abbreviation() {
    switch (this) {
      case UserGender.male:
        return 'M';

      case UserGender.female:
        return 'F';
    }
  }
}

extension GenderByString on String {
  UserGender toGender() {
    switch (toLowerCase()) {
      case 'masculino':
        return UserGender.male;
      case 'feminino':
        return UserGender.female;
      default:
        return UserGender.male;
    }
  }
}

class ConectaUser {
  final String sub;
  final bool emailVerified;
  final int securityLevel;
  final String name;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String userType;
  final String email;
  final bool alreadyExists;

  ConectaUser({
    required this.sub,
    required this.emailVerified,
    required this.securityLevel,
    required this.name,
    required this.preferredUsername,
    required this.givenName,
    required this.familyName,
    required this.userType,
    required this.email,
    required this.alreadyExists,
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
      'alreadyExists': alreadyExists,
    };
  }

  factory ConectaUser.fromMap(Map<String, dynamic> map) {
    return ConectaUser(
      sub: map['sub'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      securityLevel: map['securityLevel']?.toInt() ?? 0,
      name: map['name'] ?? '',
      preferredUsername: map['preferredUsername'] ?? '',
      givenName: map['givenName'] ?? '',
      familyName: map['familyName'] ?? '',
      userType: map['userType'] ?? '',
      email: map['email'] ?? '',
      alreadyExists: map['alreadyExists'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConectaUser.fromJson(String source) =>
      ConectaUser.fromMap(json.decode(source));
}
