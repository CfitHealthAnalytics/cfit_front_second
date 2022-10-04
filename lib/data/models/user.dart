import 'package:cfit/data/entity/conecta_user.dart';
import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/entity/events_public.dart';
import 'package:cfit/data/entity/feed.dart';

abstract class UserRepository {
  Future<UserBodyResponse> getUser();
  Future<UserBodyResponse> getUserByEmail(String email);
  Future<bool> addConectaUser(AddConectaUserRequest request);
  Future<List<String>> getAdmins();
  Future<List<EventCityResponse>?> getUserEventsCity();
  Future<List<EventPublicResponse>?> getUserEventsPublic();
  Future<List<EventPublicResponse>?> getUserEventsCreator();
  Future<ConectaUserInfoResponse> getConectaUserInfo();
  Future<bool> isConectaUser();
  Future<bool> setConectaUser(bool isConectaUser);
  Future<bool> setUserInStorage(UserBodyResponse user);
  Future<UserBodyResponse> getUserInStorage();
}
