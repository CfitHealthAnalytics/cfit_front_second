import 'package:cfit/domain/models/bio_info.dart';
import 'package:flutter/foundation.dart';

class MyMeasureState {
  final bool loadingRequest;
  final bool hasError;
  final Map<DateTime, double>? chartData;
  final BioInfo? bioInfo;

  MyMeasureState({
    required this.loadingRequest,
    required this.hasError,
    this.chartData,
    this.bioInfo,
  });

  factory MyMeasureState.empty() {
    return MyMeasureState(
      loadingRequest: false,
      hasError: false,
    );
  }
  MyMeasureState copyWith({
    bool? loadingRequest,
    bool? hasError,
    Map<DateTime, double>? chartData,
    BioInfo? bioInfo,
  }) {
    return MyMeasureState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      hasError: hasError ?? this.hasError,
      chartData: chartData ?? this.chartData,
      bioInfo: bioInfo ?? this.bioInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyMeasureState &&
        other.loadingRequest == loadingRequest &&
        other.hasError == hasError &&
        mapEquals(other.chartData, chartData) &&
        other.bioInfo == bioInfo;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        hasError.hashCode ^
        chartData.hashCode ^
        bioInfo.hashCode;
  }
}
