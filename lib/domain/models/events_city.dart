import 'dart:convert';

import 'coordinates.dart';

class EventCity {
  String street;
  String neighborhood;
  String number;
  DateTime startTime;
  String type;
  int countUsers;
  List<String> usersCheckIn;
  List<String> usersConfirmation;
  String description;
  String city;
  Coordinates coordinates;
  DateTime createdAt;
  String name;
  int countMaxUsers;
  String id;

  EventCity({
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

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'neighborhood': neighborhood,
      'number': number,
      'startTime': startTime.millisecondsSinceEpoch,
      'type': type,
      'countUsers': countUsers,
      'usersCheckIn': usersCheckIn,
      'usersConfirmation': usersConfirmation,
      'description': description,
      'city': city,
      'coordinates': coordinates.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'name': name,
      'countMaxUsers': countMaxUsers,
      'id': id,
    };
  }

  factory EventCity.fromMap(Map<String, dynamic> map) {
    return EventCity(
      street: map['street'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      number: map['number'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      type: map['type'] ?? '',
      countUsers: map['countUsers']?.toInt() ?? 0,
      usersCheckIn: List<String>.from(map['usersCheckIn']),
      usersConfirmation: List<String>.from(map['usersConfirmation']),
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      coordinates: Coordinates.fromMap(map['coordinates']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      name: map['name'] ?? '',
      countMaxUsers: map['countMaxUsers']?.toInt() ?? 0,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventCity.fromJson(String source) =>
      EventCity.fromMap(json.decode(source));
}
