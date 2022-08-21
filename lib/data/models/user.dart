import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/entity/feed.dart';

abstract class UserRepository {
  Future<UserBodyResponse> getUser();
  Future<List<String>> getAdmins();
  Future<List<EventCityResponse>?> getUserEvents();
}
