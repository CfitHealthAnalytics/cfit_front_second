import 'package:logger/logger.dart';

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException({this.message = 'Login ou senha inválidos'}) {
    Logger().w(message);
  }

  @override
  String toString() => message;
}
