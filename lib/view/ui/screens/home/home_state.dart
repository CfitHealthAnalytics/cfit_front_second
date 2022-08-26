import 'package:cfit/domain/models/events.dart';
import 'package:cfit/domain/models/feed.dart';

class HomeState {
  final Feed? feed;
  final bool loadingRequestInit;
  final bool loadingRequestGetEvents;
  final bool loadingRequestGetEventsPublic;
  final bool alreadyLoaded;
  final HomeStateEventsFilter filter;

  HomeState({
    this.feed,
    required this.loadingRequestInit,
    required this.loadingRequestGetEvents,
    required this.loadingRequestGetEventsPublic,
    required this.alreadyLoaded,
    required this.filter,
  });
  factory HomeState.empty() {
    return HomeState(
      loadingRequestInit: false,
      loadingRequestGetEvents: false,
      loadingRequestGetEventsPublic: false,
      alreadyLoaded: false,
      filter: HomeStateEventsFilter.all,
    );
  }
  HomeState copyWith({
    Feed? feed,
    bool? loadingRequestInit,
    bool? loadingRequestGetEvents,
    bool? loadingRequestGetEventsPublic,
    bool? alreadyLoaded,
    HomeStateEventsFilter? filter,
  }) {
    return HomeState(
      feed: feed ?? this.feed,
      loadingRequestInit: loadingRequestInit ?? this.loadingRequestInit,
      loadingRequestGetEvents:
          loadingRequestGetEvents ?? this.loadingRequestGetEvents,
      loadingRequestGetEventsPublic:
          loadingRequestGetEventsPublic ?? this.loadingRequestGetEventsPublic,
      alreadyLoaded: alreadyLoaded ?? this.alreadyLoaded,
      filter: filter ?? this.filter,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.feed == feed &&
        other.loadingRequestInit == loadingRequestInit &&
        other.loadingRequestGetEvents == loadingRequestGetEvents &&
        other.loadingRequestGetEventsPublic == loadingRequestGetEventsPublic &&
        other.alreadyLoaded == alreadyLoaded &&
        other.filter == filter;
  }

  @override
  int get hashCode {
    return feed.hashCode ^
        loadingRequestInit.hashCode ^
        loadingRequestGetEvents.hashCode ^
        loadingRequestGetEventsPublic.hashCode ^
        alreadyLoaded.hashCode ^
        filter.hashCode;
  }
}

enum HomeStateEventsFilter { all, gymCity, my, public }

extension HomeStateEventsHandler on HomeState {
  List<Event> get events {
    switch (filter) {
      case HomeStateEventsFilter.all:
        return [
          ...feed?.gymCity ?? [],
          ...feed?.myEvents ?? [],
          ...feed?.publicEvents ?? [],
        ];

      case HomeStateEventsFilter.gymCity:
        return [
          ...feed?.gymCity ?? [],
        ];

      case HomeStateEventsFilter.my:
        return [
          ...feed?.myEvents ?? [],
        ];

      case HomeStateEventsFilter.public:
        return [
          ...feed?.publicEvents ?? [],
        ];
    }
  }
}
