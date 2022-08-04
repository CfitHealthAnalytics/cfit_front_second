class LoginState {
  final String email;
  final String password;
  final bool loadingRequest;
  final bool hasError;

  LoginState({
    required this.email,
    required this.password,
    required this.loadingRequest,
    required this.hasError,
  });

  factory LoginState.empty() {
    return LoginState(
      email: '',
      password: '',
      loadingRequest: false,
      hasError: false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.email == email &&
        other.password == password &&
        other.loadingRequest == loadingRequest &&
        other.hasError == hasError;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        loadingRequest.hashCode ^
        hasError.hashCode;
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? loadingRequest,
    bool? hasError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loadingRequest: loadingRequest ?? this.loadingRequest,
      hasError: hasError ?? this.hasError,
    );
  }
}

extension LoginStateEnabled on LoginState {
  bool get isEnabled => email.isNotEmpty && password.isNotEmpty;
}
