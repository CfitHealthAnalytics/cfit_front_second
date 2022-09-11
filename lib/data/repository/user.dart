import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/entity/events_public.dart';
import 'package:cfit/data/entity/feed.dart';
import 'package:cfit/data/models/user.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/external/models/storage.dart';
import 'package:cfit/util/app_constants.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient client;
  final Storage storage;

  UserRepositoryImpl({
    required this.client,
    required this.storage,
  });

  @override
  Future<UserBodyResponse> getUser() async {
    final idToken = await storage.get(AppConstants.TOKEN);
    final response = await client.post(
      path: AppConstants.GET_USER,
      body: UserBodyRequest(idToken: idToken).toMap(),
    );
    final userId = await storage.get(AppConstants.USER_ID);
    return UserBodyResponse.fromMap({...response.data, 'id': userId});
  }

  @override
  Future<List<EventCityResponse>?> getUserEventsCity() async {
    final userId = await storage.get(AppConstants.USER_ID);
    try {
      final response = await client.get(
        path: AppConstants.GET_MY_CITY_EVENTS,
        query: {'user_id': userId},
      );
      final cleanList = (response.data['responses'] as List)
          .where((element) => element != null)
          .toList();
      // TODO: remove this when dont have events with user_checkin as string only
      cleanList.removeWhere(
          (element) => (element['users_checkin'] as List).first is String);

      return cleanList
          .map((event) => EventCityResponse.fromMap(event!))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<String>> getAdmins() async {
    final response = await client.get(path: AppConstants.GET_USERS_ADMIN);

    return (response.data['responses'][0]['users'] as List)
        .map((e) => e.toString())
        .toList();
  }

  @override
  Future<List<EventPublicResponse>?> getUserEventsPublic() async {
    final userId = await storage.get(AppConstants.USER_ID);
    try {
      final response = await client.get(
        path: AppConstants.GET_MY_PUBLIC_EVENTS,
        query: {'user_id': userId},
      );
      final cleanList = (response.data['responses'] as List)
          .where((element) => element != null)
          .toList();
      // TODO: remove this when dont have events with user_checkin as string only
      cleanList.removeWhere(
          (element) => (element['users_checkin'] as List).first is String);

      return cleanList
          .map((event) => EventPublicResponse.fromMap(event!))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<EventPublicResponse>?> getUserEventsCreator() async {
    try {
      final userId = await storage.get(AppConstants.USER_ID);
      final response = await client.get(
        path: AppConstants.GET_MY_EVENTS,
        query: {'user_id': userId},
      );
      final cleanList = (response.data['responses'] as List)
          .where((element) => element != null)
          .toList();
      // TODO: remove this when dont have events with user_checkin as string only
      // cleanList.removeWhere(
      //     (element) => (element['users_checkin'] as List).first is String);

      return cleanList
          .map((event) => EventPublicResponse.fromMap(event!))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
