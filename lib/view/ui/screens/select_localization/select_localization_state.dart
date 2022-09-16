import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocalizationState {
  final bool loadingRequest;
  final bool loadingPlaces;
  final String? errorMessage;
  final String? searchText;
  final SelectLocalizationStatus status;
  final LatLng position;
  final bool actionPressed;
  final bool searchBarPressed;

  SelectLocalizationState({
    required this.loadingRequest,
    required this.loadingPlaces,
    this.errorMessage,
    this.searchText,
    required this.status,
    required this.position,
    required this.actionPressed,
    required this.searchBarPressed,
  });

  factory SelectLocalizationState.empty() {
    return SelectLocalizationState(
      loadingRequest: false,
      loadingPlaces: false,
      errorMessage: null,
      status: SelectLocalizationStatus.none,
      position: const LatLng(
        -8.056222986074129,
        -34.93490595758101,
      ),
      actionPressed: false,
      searchBarPressed: false,
    );
  }
  SelectLocalizationState copyWith({
    bool? loadingRequest,
    bool? loadingPlaces,
    String? errorMessage,
    String? searchText,
    SelectLocalizationStatus? status,
    LatLng? position,
    bool? actionPressed,
    bool? searchBarPressed,
  }) {
    return SelectLocalizationState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      loadingPlaces: loadingPlaces ?? this.loadingPlaces,
      errorMessage: errorMessage ?? this.errorMessage,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      position: position ?? this.position,
      actionPressed: actionPressed ?? this.actionPressed,
      searchBarPressed: searchBarPressed ?? this.searchBarPressed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SelectLocalizationState &&
        other.loadingRequest == loadingRequest &&
        other.loadingPlaces == loadingPlaces &&
        other.errorMessage == errorMessage &&
        other.searchText == searchText &&
        other.status == status &&
        other.position == position &&
        other.actionPressed == actionPressed &&
        other.searchBarPressed == searchBarPressed;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        loadingPlaces.hashCode ^
        errorMessage.hashCode ^
        searchText.hashCode ^
        status.hashCode ^
        position.hashCode ^
        actionPressed.hashCode ^
        searchBarPressed.hashCode;
  }
}

enum SelectLocalizationStatus { none, failed, succeeds }
