import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocalizationState {
  final bool loadingRequest;
  final String? errorMessage;
  final SelectLocalizationStatus status;
  final LatLng position;
  final bool actionPressed;

  SelectLocalizationState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
    required this.position,
    required this.actionPressed,
  });

  factory SelectLocalizationState.empty() {
    return SelectLocalizationState(
      loadingRequest: false,
      errorMessage: null,
      status: SelectLocalizationStatus.none,
      position: const LatLng(
        -8.056222986074129,
        -34.93490595758101,
      ),
      actionPressed: false,
    );
  }
  SelectLocalizationState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    SelectLocalizationStatus? status,
    LatLng? position,
    bool? actionPressed,
  }) {
    return SelectLocalizationState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      position: position ?? this.position,
      actionPressed: actionPressed ?? this.actionPressed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SelectLocalizationState &&
        other.loadingRequest == loadingRequest &&
        other.errorMessage == errorMessage &&
        other.status == status &&
        other.position == position &&
        other.actionPressed == actionPressed;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        errorMessage.hashCode ^
        status.hashCode ^
        position.hashCode ^
        actionPressed.hashCode;
  }
}

enum SelectLocalizationStatus { none, failed, succeeds }
