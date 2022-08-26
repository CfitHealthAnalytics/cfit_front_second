class EventPublicDetailsState {
  final bool loadingRequest;
  final String? errorMessage;
  final EventPublicDetailsStatus status;

  EventPublicDetailsState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
  });

  factory EventPublicDetailsState.empty() {
    return EventPublicDetailsState(
      loadingRequest: false,
      errorMessage: null,
      status: EventPublicDetailsStatus.none,
    );
  }
  EventPublicDetailsState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    EventPublicDetailsStatus? status,
  }) {
    return EventPublicDetailsState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventPublicDetailsState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^ errorMessage.hashCode ^ status.hashCode;
}

enum EventPublicDetailsStatus { none, failed, succeeds }
