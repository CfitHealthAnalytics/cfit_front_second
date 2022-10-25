import 'package:cfit/data/entity/conecta_user.dart';
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
  Future<UserBodyResponse> getUserByEmail(String email) async {
    final response = await client.post(
      path: AppConstants.GET_USER_BY_EMAIL,
      body: {
        'email': email,
      },
    );
    return UserBodyResponse.fromMap({
      ...response.data,
      'id': response.data['uid'],
    });
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

  @override
  Future<ConectaUserInfoResponse> getConectaUserInfo() async {
    final token = await storage.get(AppConstants.TOKEN);

    final response = await client.post(
      path: AppConstants.CONNECTA_USER_INFO,
      body: {'idtoken': token},
    );

    final userConnecta = ConectaUserInfoResponse.fromMap(response.data);

    await storage.set(AppConstants.USER_ID, data: userConnecta.sub);

    return userConnecta;
  }

  @override
  Future<bool> addConectaUser(AddConectaUserRequest request) async {
    await client.post(
      path: AppConstants.ADD_CONECTA_USER,
      body: request.toMap(),
    );
    return true;
  }

  @override
  Future<bool> isConectaUser() async {
    final response = await storage.get(AppConstants.IS_CONECTA_USER);
    return response ?? false;
  }

  @override
  Future<bool> setConectaUser(bool isConectaUser) async {
    await storage.set(AppConstants.IS_CONECTA_USER, data: isConectaUser);
    return true;
  }

  @override
  Future<bool> setUserInStorage(UserBodyResponse user) async {
    await storage.setAll({
      AppConstants.USER_ID: user.id,
      AppConstants.USER_EMAIL: user.email,
      AppConstants.USER_DATE_BIRTH: user.dateBirth,
      AppConstants.USER_GENDER: user.gender,
      AppConstants.USER_NAME: user.name,
    });
    return true;
  }

  @override
  Future<UserBodyResponse> getUserInStorage() async {
    final userMap = await storage.getAll({
      AppConstants.USER_ID,
      AppConstants.USER_EMAIL,
      AppConstants.USER_DATE_BIRTH,
      AppConstants.USER_GENDER,
      AppConstants.USER_NAME,
    });
    return UserBodyResponse(
      id: userMap[AppConstants.USER_ID],
      name: userMap[AppConstants.USER_NAME],
      email: userMap[AppConstants.USER_EMAIL],
      dateBirth: userMap[AppConstants.USER_DATE_BIRTH],
      gender: userMap[AppConstants.USER_GENDER],
    );
  }
}
