import 'package:cfit/domain/models/user.dart';

class RegisterState {
  final String email;
  final String name;
  final UserGender gender;
  final String dateBirth;
  final String password;
  final String confirmedPassword;
  final bool loadingRequest;
  final bool hasError;
  final bool accountExists;

  RegisterState({
    required this.email,
    required this.name,
    required this.gender,
    required this.dateBirth,
    required this.password,
    required this.confirmedPassword,
    required this.loadingRequest,
    required this.hasError,
    required this.accountExists,
  });

  factory RegisterState.empty() {
    return RegisterState(
      email: '',
      password: '',
      loadingRequest: false,
      hasError: false,
      confirmedPassword: '',
      dateBirth: '',
      gender: UserGender.male,
      name: '',
      accountExists: false,
    );
  }
  RegisterState copyWith({
    String? email,
    String? name,
    UserGender? gender,
    String? dateBirth,
    String? password,
    String? confirmedPassword,
    bool? loadingRequest,
    bool? hasError,
    bool? accountExists,
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
      accountExists: accountExists ?? this.accountExists,
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
        other.hasError == hasError &&
        other.accountExists == accountExists;
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
        hasError.hashCode ^
        accountExists.hashCode;
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
