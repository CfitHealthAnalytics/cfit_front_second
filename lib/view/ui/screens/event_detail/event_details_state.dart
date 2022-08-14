class EventDetailsState {
  final bool loadingRequest;
  final String? errorMessage;
  final EventDetailsStatus status;

  EventDetailsState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
  });

  factory EventDetailsState.empty() {
    return EventDetailsState(
      loadingRequest: false,
      errorMessage: null,
      status: EventDetailsStatus.none,
    );
  }
  EventDetailsState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    EventDetailsStatus? status,
  }) {
    return EventDetailsState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventDetailsState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^ errorMessage.hashCode ^ status.hashCode;
}

enum EventDetailsStatus { none, failed, succeeds }
