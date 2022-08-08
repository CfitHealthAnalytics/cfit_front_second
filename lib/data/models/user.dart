import 'package:cfit/data/entity/feed.dart';

abstract class UserRepository {
  Future<UserBodyResponse> getUser();
}
