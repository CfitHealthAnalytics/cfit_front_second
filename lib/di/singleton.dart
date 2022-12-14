import 'package:cfit/domain/models/user.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  User _userInternal = User.empty();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  User get user => _userInternal;

  set user(User user) {
    _userInternal = user;
  }
}
