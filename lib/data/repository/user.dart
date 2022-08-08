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
    return UserBodyResponse.fromMap(response.data);
  }
}
