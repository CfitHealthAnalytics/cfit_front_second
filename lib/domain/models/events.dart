import 'package:cfit/domain/models/coordinates.dart';
import 'package:cfit/domain/models/user.dart';

abstract class Event {
  late String street;
  late String neighborhood;
  late String number;
  late DateTime startTime;
  late String type;
  late int countUsers;
  late List<User> usersCheckIn;
  late List<String> usersConfirmation;
  late String description;
  late String city;
  late Coordinates coordinates;
  late DateTime createdAt;
  late String name;
  late int countMaxUsers;
  late String id;

  Event({
    required this.street,
    required this.neighborhood,
    required this.number,
    required this.startTime,
    required this.type,
    required this.countUsers,
    required this.usersCheckIn,
    required this.usersConfirmation,
    required this.description,
    required this.city,
    required this.coordinates,
    required this.createdAt,
    required this.name,
    required this.countMaxUsers,
    required this.id,
  });
}
