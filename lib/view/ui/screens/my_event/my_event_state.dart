class MyEventState {
  final bool loadingRequest;
  final String? errorMessage;
  final MyEventStateStatus status;

  MyEventState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
  });

  factory MyEventState.empty() {
    return MyEventState(
      loadingRequest: false,
      errorMessage: null,
      status: MyEventStateStatus.none,
    );
  }
  MyEventState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    MyEventStateStatus? status,
  }) {
    return MyEventState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyEventState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^ errorMessage.hashCode ^ status.hashCode;
}

enum MyEventStateStatus { none, failed, succeeds }
