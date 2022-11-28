import 'dart:convert';

import 'package:cfit/data/entity/feed.dart';
import 'package:cfit/domain/models/coordinates.dart';

class EventCityRequest {
  final DateTime? startTime;
  final DateTime? endTime;
  final String? city;
  final String? modality;
  final String pole;

  EventCityRequest({
    this.startTime,
    this.endTime,
    this.city,
    this.modality,
    required this.pole,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'city': city,
      'modality': modality,
      'pole': pole,
    };
  }

  factory EventCityRequest.fromMap(Map<String, dynamic> map) {
    return EventCityRequest(
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      city: map['city'],
      modality: map['modality'],
      pole: map['pole'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventCityRequest.fromJson(String source) =>
      EventCityRequest.fromMap(json.decode(source));

  EventCityRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? city,
    String? modality,
    String? pole,
  }) {
    return EventCityRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      city: city ?? this.city,
      modality: modality ?? this.modality,
      pole: pole ?? this.pole,
    );
  }

  @override
  String toString() {
    return 'EventCityRequest(startTime: $startTime, endTime: $endTime, city: $city, modality: $modality, pole: $pole)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventCityRequest &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.city == city &&
        other.modality == modality &&
        other.pole == pole;
  }

  @override
  int get hashCode {
    return startTime.hashCode ^
        endTime.hashCode ^
        city.hashCode ^
        modality.hashCode ^
        pole.hashCode;
  }
}

class EventCityResponse {
  String street;
  String neighborhood;
  String number;
  String startTime;
  String type;
  int countUsers;
  List<UserBodyResponse> usersCheckIn;
  List<String> usersConfirmation;
  String description;
  String city;
  Coordinates coordinates;
  String createdAt;
  String name;
  int countMaxUsers;
  String id;

  EventCityResponse({
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
      'startTime': startTime,
      'type': type,
      'countUsers': countUsers,
      'usersCheckIn': usersCheckIn,
      'usersConfirmation': usersConfirmation,
      'description': description,
      'city': city,
      'coordinates': coordinates.toMap(),
      'createdAt': createdAt,
      'name': name,
      'countMaxUsers': countMaxUsers,
      'id': id,
    };
  }

  factory EventCityResponse.fromMap(Map<String, dynamic> map) {
    return EventCityResponse(
      street: map['rua'] ?? '',
      neighborhood: map['bairro'] ?? '',
      number: map['numero'] ?? '',
      startTime: map['horario_de_inicio'] ?? '',
      type: map['tipo'] ?? '',
      countUsers: map['qtd_user']?.toInt() ?? 0,
      usersCheckIn: List<UserBodyResponse>.from(
        (map['users_checkin'] as List)
            .map((user) => UserBodyResponse.fromMap(user))
            .toList(),
      ),
      usersConfirmation: List<String>.from(map['users_confirmation']),
      description: map['descricao'] ?? '',
      city: map['cidade'] ?? '',
      coordinates: Coordinates.fromMap(map['coordenadas']),
      createdAt: map['created_at'] ?? '',
      name: map['name'] ?? '',
      countMaxUsers: map['qtd_max_user']?.toInt() ?? 0,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventCityResponse.fromJson(String source) =>
      EventCityResponse.fromMap(json.decode(source));
}
