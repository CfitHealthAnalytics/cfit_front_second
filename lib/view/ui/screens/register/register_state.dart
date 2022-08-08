enum Gender { male, female }

class RegisterState {
  final String email;
  final String name;
  final Gender gender;
  final String dateBirth;
  final String password;
  final String confirmedPassword;
  final bool loadingRequest;
  final bool hasError;

  RegisterState({
    required this.email,
    required this.name,
    required this.gender,
    required this.dateBirth,
    required this.password,
    required this.confirmedPassword,
    required this.loadingRequest,
    required this.hasError,
  });

  factory RegisterState.empty() {
    return RegisterState(
      email: '',
      password: '',
      loadingRequest: false,
      hasError: false,
      confirmedPassword: '',
      dateBirth: '',
      gender: Gender.male,
      name: '',
    );
  }
  RegisterState copyWith({
    String? email,
    String? name,
    Gender? gender,
    String? dateBirth,
    String? password,
    String? confirmedPassword,
    bool? loadingRequest,
    bool? hasError,
  }) {
    return RegisterState(
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateBirth: dateBirth ?? this.dateBirth,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      loadingRequest: loadingRequest ?? this.loadingRequest,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterState &&
        other.email == email &&
        other.name == name &&
        other.gender == gender &&
        other.dateBirth == dateBirth &&
        other.password == password &&
        other.confirmedPassword == confirmedPassword &&
        other.loadingRequest == loadingRequest &&
        other.hasError == hasError;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        dateBirth.hashCode ^
        password.hashCode ^
        confirmedPassword.hashCode ^
        loadingRequest.hashCode ^
        hasError.hashCode;
  }
}

extension RegisterStateEnabled on RegisterState {
  bool get isEnabled =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmedPassword.isNotEmpty &&
      dateBirth.isNotEmpty &&
      name.isNotEmpty &&
      password == confirmedPassword;
}

extension GenderStringRepresentation on Gender {
  String toStringRepresentation() {
    switch (this) {
      case Gender.male:
        return 'masculino';

      case Gender.female:
        return 'feminino';
    }
  }
}
