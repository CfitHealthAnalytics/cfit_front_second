import 'dart:convert';

import 'package:cfit/domain/models/user.dart';
import 'package:flutter/foundation.dart';

import 'coordinates.dart';
import 'events.dart';

class EventCity implements Event {
  @override
  String street;
  @override
  String neighborhood;
  @override
  String number;
  @override
  DateTime startTime;
  @override
  String type;
  @override
  int countUsers;
  @override
  List<User> usersCheckIn;
  @override
  List<String> usersConfirmation;
  @override
  String description;
  @override
  String city;
  @override
  Coordinates coordinates;
  @override
  DateTime createdAt;
  @override
  String name;
  @override
  int countMaxUsers;
  @override
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
      'startTime': startTime.toIso8601String(),
      'type': type,
      'countUsers': countUsers,
      'usersCheckIn': usersCheckIn.map((user) => user.toMap()).toList(),
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
      startTime: DateTime.parse(map['startTime']),
      type: map['type'] ?? '',
      countUsers: map['countUsers']?.toInt() ?? 0,
      usersCheckIn: List<User>.from(
        (map['usersCheckIn'] as List)
            .map((user) => User.fromMap(user))
            .toList(),
      ),
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventCity &&
        other.street == street &&
        other.neighborhood == neighborhood &&
        other.number == number &&
        other.startTime == startTime &&
        other.type == type &&
        other.countUsers == countUsers &&
        listEquals(other.usersCheckIn, usersCheckIn) &&
        listEquals(other.usersConfirmation, usersConfirmation) &&
        other.description == description &&
        other.city == city &&
        other.coordinates == coordinates &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.countMaxUsers == countMaxUsers &&
        other.id == id;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        neighborhood.hashCode ^
        number.hashCode ^
        startTime.hashCode ^
        type.hashCode ^
        countUsers.hashCode ^
        usersCheckIn.hashCode ^
        usersConfirmation.hashCode ^
        description.hashCode ^
        city.hashCode ^
        coordinates.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        countMaxUsers.hashCode ^
        id.hashCode;
  }
}
