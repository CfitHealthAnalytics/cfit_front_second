import 'package:bloc/bloc.dart';
import 'package:cfit/domain/erros/rules.dart';
import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/events_in_city_use_case.dart';
import 'package:cfit/domain/use_cases/events_public_use_case.dart';
import 'package:cfit/domain/use_cases/feed_use_case.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.feedUseCase,
    required this.eventsInCityUseCase,
    required this.eventsPublicUseCase,
    required this.navigation,
  }) : super(HomeState.empty());

  final HomeNavigation navigation;
  final FeedUseCase feedUseCase;
  final EventsInCityUseCase eventsInCityUseCase;
  final EventsPublicUseCase eventsPublicUseCase;

  bool alreadyTried = false;
  User? get user => state.feed?.user;

  String? get qrData =>
      'CF*${user?.id}*${user?.dateBirth.replaceAll('/', '')}*${user?.gender.abbreviation()}';

  bool get alreadyLoaded => state.alreadyLoaded;

  void setAlreadyLoaded() {
    emit(state.copyWith(alreadyLoaded: true));
  }

  void setNotAlreadyLoaded() {
    emit(state.copyWith(alreadyLoaded: false));
  }

  void setFilterDashboard(HomeStateEventsFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  Future<void> init() async {
    try {
      emit(
        state.copyWith(loadingRequestInit: true),
      );
      final user = await feedUseCase.getUser();
      final gymCityEvents = await feedUseCase.getGymCityEvents();
      final publicEvents = await feedUseCase.getPublicEvents();
      final myEvents = await feedUseCase.getMyEvents();
      emit(state.copyWith(
        loadingRequestInit: false,
        feed: Feed(
          user: user,
          gymCity: gymCityEvents ?? [],
          publicEvents: publicEvents ?? [],
          myEvents: myEvents ?? [],
        ),
        alreadyLoaded: true,
      ));
    } on UnauthorizedException catch (_) {
      emit(state.copyWith(
        loadingRequestInit: false,
        alreadyLoaded: true,
      ));
      navigation.toLogin();
    } on NotLoggedUser catch (_) {
      emit(state.copyWith(
        loadingRequestInit: false,
        alreadyLoaded: true,
      ));
      navigation.toLogin();
    } catch (e) {
      emit(state.copyWith(
        loadingRequestInit: false,
        alreadyLoaded: true,
      ));
      if (alreadyTried == false) {
        alreadyTried = true;
        return await init();
      }
    }
  }

  Future<List<EventCity>?> getConfirmedEvent() async {
    try {
      emit(
        state.copyWith(loadingRequestGetEvents: true),
      );
      final gymCityEvents = await feedUseCase.getGymCityEvents();
      final publicEvents = await feedUseCase.getPublicEvents();
      final myEvents = await feedUseCase.getMyEvents();
      emit(state.copyWith(
        loadingRequestGetEvents: false,
        feed: Feed(
          user: state.feed!.user,
          gymCity: gymCityEvents ?? [],
          publicEvents: publicEvents ?? [],
          myEvents: myEvents ?? [],
        ),
        alreadyLoaded: true,
      ));
      return gymCityEvents;
    } on UnauthorizedException catch (_) {
      emit(state.copyWith(
        loadingRequestGetEvents: false,
        alreadyLoaded: true,
      ));
      navigation.toLogin();
    } on NotLoggedUser catch (_) {
      emit(state.copyWith(
        loadingRequestGetEvents: false,
        alreadyLoaded: true,
      ));
      navigation.toLogin();
    } catch (e) {
      emit(state.copyWith(
        loadingRequestGetEvents: false,
        alreadyLoaded: true,
      ));
      if (alreadyTried == false) {
        alreadyTried = true;
        return await getConfirmedEvent();
      }
    }
    return null;
  }

  Future<List<EventCity>> getEventsCity({
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    late DateTime _endTime;
    if (endTime == null) {
      _endTime = DateTime(
        startTime.year,
        startTime.month,
        startTime.day,
        23,
        59,
      );
    } else {
      _endTime = endTime;
    }

    final events = await eventsInCityUseCase(
      startTime: startTime,
      endTime: _endTime,
    );

    return events;
  }

  Future<List<EventPublic>> getEventsPublic() async {
    final events = await eventsPublicUseCase();

    return events;
  }

  Future<Address?> getAddress() async {
    final address = await navigation.toMap(
      toCreateEvent: false,
      user: user!,
    );
    return address;
  }

  Future<void> toCreateEvent() async {
    await navigation.toMap(
      toCreateEvent: true,
      user: user!,
    );
  }
}
