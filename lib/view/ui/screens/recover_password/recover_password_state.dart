class RecoverPasswordState {
  final String email;
  final String confirmEmail;
  final Status status;
  final bool loadingRequest;
  final bool hasError;

  RecoverPasswordState({
    required this.email,
    required this.confirmEmail,
    required this.status,
    required this.loadingRequest,
    required this.hasError,
  });

  factory RecoverPasswordState.empty() {
    return RecoverPasswordState(
      email: '',
      confirmEmail: '',
      status: Status.idle,
      loadingRequest: false,
      hasError: false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecoverPasswordState &&
        other.email == email &&
        other.confirmEmail == confirmEmail &&
        other.status == status &&
        other.loadingRequest == loadingRequest &&
        other.hasError == hasError;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        confirmEmail.hashCode ^
        status.hashCode ^
        loadingRequest.hashCode ^
        hasError.hashCode;
  }

  RecoverPasswordState copyWith({
    String? email,
    String? confirmEmail,
    Status? status,
    bool? loadingRequest,
    bool? hasError,
  }) {
    return RecoverPasswordState(
      email: email ?? this.email,
      confirmEmail: confirmEmail ?? this.confirmEmail,
      status: status ?? this.status,
      loadingRequest: loadingRequest ?? this.loadingRequest,
      hasError: hasError ?? this.hasError,
    );
  }
}

enum Status { idle, success, fail, notFound }

extension RecoverPasswordStateEnabled on RecoverPasswordState {
  bool get isEnabled =>
      (email.isNotEmpty && confirmEmail.isNotEmpty) && (email == confirmEmail);
}
