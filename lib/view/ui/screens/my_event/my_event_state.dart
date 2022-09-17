import 'package:cfit/domain/models/events_public.dart';

class MyEventState {
  final bool loadingRequest;
  final bool loadingPartial;
  final String? errorMessage;
  final MyEventStateStatus status;
  final EventPublic event;

  MyEventState({
    required this.loadingRequest,
    required this.loadingPartial,
    this.errorMessage,
    required this.status,
    required this.event,
  });

  factory MyEventState.empty(EventPublic event) {
    return MyEventState(
      loadingRequest: false,
      loadingPartial: false,
      errorMessage: null,
      status: MyEventStateStatus.none,
      event: event,
    );
  }
  MyEventState copyWith({
    bool? loadingRequest,
    bool? loadingPartial,
    String? errorMessage,
    MyEventStateStatus? status,
    EventPublic? event,
  }) {
    return MyEventState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
      loadingPartial: loadingPartial ?? this.loadingPartial,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      event: event ?? this.event,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyEventState &&
        other.loadingRequest == loadingRequest &&
        other.loadingPartial == loadingPartial &&
        other.errorMessage == errorMessage &&
        other.status == status &&
        other.event == event;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        loadingPartial.hashCode ^
        errorMessage.hashCode ^
        status.hashCode ^
        event.hashCode;
  }
}

enum MyEventStateStatus { none, failed, succeeds }
