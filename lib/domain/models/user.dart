class User {
  final String name;
  final String email;
  final String dateBirth;
  final UserGender gender;

  User({
    required this.name,
    required this.email,
    required this.dateBirth,
    required this.gender,
  });
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
