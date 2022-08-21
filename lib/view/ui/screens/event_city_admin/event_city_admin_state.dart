class EventCityAdminState {
  final bool loadingRequest;
  final List<String> listSelected;
  final String? errorMessage;
  final EventCityAdminStatus status;

  EventCityAdminState({
    required this.loadingRequest,
    required this.listSelected,
    this.errorMessage,
    required this.status,
  });

  factory EventCityAdminState.empty() {
    return EventCityAdminState(
        loadingRequest: false,
        errorMessage: null,
        status: EventCityAdminStatus.none,
        listSelected: []);
  }
  EventCityAdminState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    EventCityAdminStatus? status,
    List<String>? listSelected,
  }) {
    return EventCityAdminState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      listSelected: listSelected ?? this.listSelected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventCityAdminState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.listSelected == listSelected &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^
      errorMessage.hashCode ^
      listSelected.hashCode ^
      status.hashCode;
}

enum EventCityAdminStatus { none, failed, succeeds }
