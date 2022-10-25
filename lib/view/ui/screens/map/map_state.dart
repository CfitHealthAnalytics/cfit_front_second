import 'package:cfit/domain/models/poles.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final List<Pole> poles;
  final MapStatus status;
  final Set<Marker> markers;
  final String? errorMessage;

  MapState({
    required this.poles,
    required this.status,
    required this.markers,
    this.errorMessage,
  });

  factory MapState.empty() => MapState(
        poles: [],
        markers: {},
        status: MapStatus.idle,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapState &&
        listEquals(other.poles, poles) &&
        other.status == status &&
        setEquals(other.markers, markers) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return poles.hashCode ^
        status.hashCode ^
        markers.hashCode ^
        errorMessage.hashCode;
  }

  MapState copyWith({
    List<Pole>? poles,
    MapStatus? status,
    Set<Marker>? markers,
    String? errorMessage,
  }) {
    return MapState(
      poles: poles ?? this.poles,
      status: status ?? this.status,
      markers: markers ?? this.markers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum MapStatus { loading, success, fail, idle }

extension MapStatusLogic on MapStatus {
  bool get isLoading => this == MapStatus.loading;
  bool get isSuccess => this == MapStatus.success;
  bool get isFail => this == MapStatus.fail;
  bool get isIdle => this == MapStatus.idle;
}
