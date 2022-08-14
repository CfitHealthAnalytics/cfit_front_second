import 'package:cfit/domain/erros/rules.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/events_in_city_use_case.dart';
import 'package:cfit/domain/use_cases/feed_use_case.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class HomeController {
  HomeController({
    required this.feedUseCase,
    required this.eventsInCityUseCase,
    required this.navigation,
  });
  final HomeNavigation navigation;
  final FeedUseCase feedUseCase;
  final EventsInCityUseCase eventsInCityUseCase;

  late final User _user;
  bool alreadyTried = false;
  User get user => _user;

  String get qrData =>
      'CF*${user.id}*${user.dateBirth.replaceAll('/', '')}*${user.gender.abbreviation()}';

  Future<Feed?> init() async {
    try {
      final feed = await feedUseCase();
      _user = feed.user;

      return feed;
    } on UnauthorizedException catch (_) {
      navigation.toLogin();
    } on NotLoggedUser catch (_) {
      navigation.toLogin();
    } catch (e) {
      if (alreadyTried == false) {
        alreadyTried = true;
        return await init();
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
}
