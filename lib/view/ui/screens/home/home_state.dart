import 'package:cfit/domain/models/feed.dart';

class HomeState {
  final Feed? feed;
  final bool loadingRequestInit;
  final bool loadingRequestGetEvents;
  final bool alreadyLoaded;
  HomeState({
    this.feed,
    required this.loadingRequestInit,
    required this.loadingRequestGetEvents,
    required this.alreadyLoaded,
  });
  factory HomeState.empty() {
    return HomeState(
      loadingRequestInit: false,
      loadingRequestGetEvents: false,
      alreadyLoaded: false,
    );
  }
  HomeState copyWith({
    Feed? feed,
    bool? loadingRequestInit,
    bool? loadingRequestGetEvents,
    bool? alreadyLoaded,
  }) {
    return HomeState(
      feed: feed ?? this.feed,
      loadingRequestInit: loadingRequestInit ?? this.loadingRequestInit,
      loadingRequestGetEvents:
          loadingRequestGetEvents ?? this.loadingRequestGetEvents,
      alreadyLoaded: alreadyLoaded ?? this.alreadyLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.feed == feed &&
        other.loadingRequestInit == loadingRequestInit &&
        other.loadingRequestGetEvents == loadingRequestGetEvents &&
        other.alreadyLoaded == alreadyLoaded;
  }

  @override
  int get hashCode {
    return feed.hashCode ^
        loadingRequestInit.hashCode ^
        loadingRequestGetEvents.hashCode ^
        alreadyLoaded.hashCode;
  }
}
