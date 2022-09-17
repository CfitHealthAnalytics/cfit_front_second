import 'dart:convert';

import 'package:cfit/domain/models/coordinates.dart';
import 'package:cfit/domain/models/events.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class EventPublic implements Event {
  @override
  String number;
  @override
  String city;
  @override
  Coordinates coordinates;
  @override
  String street;
  @override
  int countUsers;
  @override
  List<User> usersCheckIn;
  bool status;
  @override
  List<String> usersConfirmation;
  List<String> usersRejection;
  List<String> usersLike;
  @override
  String id;
  @override
  DateTime startTime;
  @override
  String neighborhood;
  @override
  String type;
  @override
  String name;
  User userCreator;
  @override
  DateTime createdAt;
  @override
  int countMaxUsers;
  @override
  String description;

  EventPublic({
    required this.number,
    required this.city,
    required this.coordinates,
    required this.street,
    required this.countUsers,
    required this.usersCheckIn,
    required this.status,
    required this.usersConfirmation,
    required this.usersRejection,
    required this.usersLike,
    required this.id,
    required this.startTime,
    required this.neighborhood,
    required this.type,
    required this.name,
    required this.userCreator,
    required this.createdAt,
    required this.countMaxUsers,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'city': city,
      'coordinates': coordinates.toMap(),
      'street': street,
      'countUsers': countUsers,
      'usersCheckIn': usersCheckIn.map((x) => x.toMap()).toList(),
      'status': status,
      'usersConfirmation': usersConfirmation,
      'usersRejection': usersRejection,
      'usersLike': usersLike,
      'id': id,
      'startTime': startTime.toIso8601String(),
      'neighborhood': neighborhood,
      'type': type,
      'name': name,
      'userCreator': userCreator.toMap(),
      'createdAt': startTime.toIso8601String(),
      'countMaxUsers': countMaxUsers,
      'description': description,
    };
  }

  factory EventPublic.fromMap(Map<String, dynamic> map) {
    return EventPublic(
      number: map['number'] ?? '',
      city: map['city'] ?? '',
      coordinates: Coordinates.fromMap(map['coordinates']),
      street: map['street'] ?? '',
      countUsers: map['countUsers']?.toInt() ?? 0,
      usersCheckIn:
          List<User>.from(map['usersCheckIn']?.map((x) => User.fromMap(x))),
      status: map['status'] ?? false,
      usersConfirmation: List<String>.from(map['usersConfirmation']),
      usersRejection: List<String>.from(map['usersRejection'] ?? []),
      usersLike: List<String>.from(map['usersLike']),
      id: map['id'] ?? '',
      startTime: DateTime.parse(map['startTime']),
      neighborhood: map['neighborhood'] ?? '',
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      userCreator: User.fromMap(map['userCreator']),
      createdAt: DateTime.parse(map['createdAt']),
      countMaxUsers: map['countMaxUsers']?.toInt() ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventPublic.fromJson(String source) =>
      EventPublic.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventPublic &&
        other.number == number &&
        other.city == city &&
        other.coordinates == coordinates &&
        other.street == street &&
        other.countUsers == countUsers &&
        listEquals(other.usersCheckIn, usersCheckIn) &&
        other.status == status &&
        listEquals(other.usersConfirmation, usersConfirmation) &&
        listEquals(other.usersLike, usersLike) &&
        other.id == id &&
        other.startTime == startTime &&
        other.neighborhood == neighborhood &&
        other.type == type &&
        other.name == name &&
        other.userCreator == userCreator &&
        other.createdAt == createdAt &&
        other.countMaxUsers == countMaxUsers &&
        other.description == description;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        city.hashCode ^
        coordinates.hashCode ^
        street.hashCode ^
        countUsers.hashCode ^
        usersCheckIn.hashCode ^
        status.hashCode ^
        usersConfirmation.hashCode ^
        usersLike.hashCode ^
        id.hashCode ^
        startTime.hashCode ^
        neighborhood.hashCode ^
        type.hashCode ^
        name.hashCode ^
        userCreator.hashCode ^
        createdAt.hashCode ^
        countMaxUsers.hashCode ^
        description.hashCode;
  }
}
