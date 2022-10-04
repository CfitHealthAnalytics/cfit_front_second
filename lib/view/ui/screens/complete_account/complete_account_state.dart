import 'package:cfit/domain/models/user.dart';

class CompleteAccountState {
  final Status status;
  final UserGender gender;
  final String dateBirth;
  final bool loadingRequest;
  final bool hasError;

  CompleteAccountState({
    required this.status,
    required this.gender,
    required this.dateBirth,
    required this.loadingRequest,
    required this.hasError,
  });

  factory CompleteAccountState.empty() {
    return CompleteAccountState(
      dateBirth: '',
      gender: UserGender.male,
      status: Status.idle,
      loadingRequest: false,
      hasError: false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompleteAccountState &&
        other.status == status &&
        other.gender == gender &&
        other.dateBirth == dateBirth &&
        other.loadingRequest == loadingRequest &&
        other.hasError == hasError;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        gender.hashCode ^
        dateBirth.hashCode ^
        loadingRequest.hashCode ^
        hasError.hashCode;
  }

  CompleteAccountState copyWith({
    Status? status,
    UserGender? gender,
    String? dateBirth,
    bool? loadingRequest,
    bool? hasError,
  }) {
    return CompleteAccountState(
      status: status ?? this.status,
      gender: gender ?? this.gender,
      dateBirth: dateBirth ?? this.dateBirth,
      loadingRequest: loadingRequest ?? this.loadingRequest,
      hasError: hasError ?? this.hasError,
    );
  }
}

enum Status { idle, success, fail, notFound }

extension CompleteAccountStateEnabled on CompleteAccountState {
  bool get isEnabled => dateBirth.isNotEmpty;
}
