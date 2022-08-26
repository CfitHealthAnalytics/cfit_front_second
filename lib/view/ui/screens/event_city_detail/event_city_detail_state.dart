class EventCityDetailsState {
  final bool loadingRequest;
  final String? errorMessage;
  final EventCityDetailsStatus status;

  EventCityDetailsState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
  });

  factory EventCityDetailsState.empty() {
    return EventCityDetailsState(
      loadingRequest: false,
      errorMessage: null,
      status: EventCityDetailsStatus.none,
    );
  }
  EventCityDetailsState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    EventCityDetailsStatus? status,
  }) {
    return EventCityDetailsState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventCityDetailsState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^ errorMessage.hashCode ^ status.hashCode;
}

enum EventCityDetailsStatus { none, failed, succeeds }
