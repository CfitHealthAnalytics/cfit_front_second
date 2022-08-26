class SelectLocalizationState {
  final bool loadingRequest;
  final String? errorMessage;
  final SelectLocalizationStatus status;

  SelectLocalizationState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
  });

  factory SelectLocalizationState.empty() {
    return SelectLocalizationState(
      loadingRequest: false,
      errorMessage: null,
      status: SelectLocalizationStatus.none,
    );
  }
  SelectLocalizationState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    SelectLocalizationStatus? status,
  }) {
    return SelectLocalizationState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectLocalizationState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode =>
      loadingRequest.hashCode ^ errorMessage.hashCode ^ status.hashCode;
}

enum SelectLocalizationStatus { none, failed, succeeds }
