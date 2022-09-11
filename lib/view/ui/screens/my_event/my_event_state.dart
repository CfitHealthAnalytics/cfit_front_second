import 'package:cfit/domain/models/events_public.dart';

class MyEventState {
  final bool loadingRequest;
  final String? errorMessage;
  final MyEventStateStatus status;
  final EventPublic event;

  MyEventState({
    required this.loadingRequest,
    this.errorMessage,
    required this.status,
    required this.event,
  });

  factory MyEventState.empty(EventPublic event) {
    return MyEventState(
      loadingRequest: false,
      errorMessage: null,
      status: MyEventStateStatus.none,
      event: event,
    );
  }
  MyEventState copyWith({
    bool? loadingRequest,
    String? errorMessage,
    MyEventStateStatus? status,
    EventPublic? event,
  }) {
    return MyEventState(
      loadingRequest: loadingRequest ?? this.loadingRequest,
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
        other.errorMessage == errorMessage &&
        other.status == status &&
        other.event == event;
  }

  @override
  int get hashCode {
    return loadingRequest.hashCode ^
        errorMessage.hashCode ^
        status.hashCode ^
        event.hashCode;
  }
}

enum MyEventStateStatus { none, failed, succeeds }
