import 'dart:convert';

import 'package:cfit/data/entity/feed.dart';
import 'package:cfit/domain/models/coordinates.dart';

class EventPublicResponse {
  String street;
  String neighborhood;
  String number;
  String startTime;
  String type;
  UserBodyResponse userCreator;
  int countUsers;
  List<UserBodyResponse> usersCheckIn;
  List<String> usersConfirmation;
  List<String> usersLike;
  String description;
  String city;
  Coordinates coordinates;
  String createdAt;
  String name;
  int countMaxUsers;
  String id;
  bool status;

  EventPublicResponse({
    required this.street,
    required this.neighborhood,
    required this.number,
    required this.startTime,
    required this.type,
    required this.countUsers,
    required this.usersCheckIn,
    required this.usersLike,
    required this.usersConfirmation,
    required this.description,
    required this.city,
    required this.coordinates,
    required this.createdAt,
    required this.name,
    required this.countMaxUsers,
    required this.id,
    required this.status,
    required this.userCreator,
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
      'usersLike': usersLike,
      'usersConfirmation': usersConfirmation,
      'description': description,
      'city': city,
      'coordinates': coordinates.toMap(),
      'createdAt': createdAt,
      'name': name,
      'countMaxUsers': countMaxUsers,
      'id': id,
      'status': status,
      'user_create_info': userCreator.toMap(),
    };
  }

  factory EventPublicResponse.fromMap(Map<String, dynamic> map) {
    return EventPublicResponse(
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
      usersLike: List<String>.from(map['users_like']),
      description: map['descricao'] ?? '',
      city: map['cidade'] ?? '',
      coordinates: Coordinates.fromMap(map['coordenadas']),
      createdAt: map['created_at'] ?? '',
      name: map['name'] ?? '',
      countMaxUsers: map['qtd_max_user']?.toInt() ?? 0,
      id: map['id'] ?? '',
      status: map['status'] ?? true,
      userCreator: UserBodyResponse.fromMap(map['user_create_info']) ??
          UserBodyResponse(
            id: '',
            name: '',
            email: '',
            dateBirth: '',
            gender: 'masculino',
          ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventPublicResponse.fromJson(String source) =>
      EventPublicResponse.fromMap(json.decode(source));
}

class CreateEventPublicRequest {
  final String city;
  final String neighborhood;
  final String street;
  final String number;
  final String name;
  final double lat;
  final double long;
  final String type;
  final String description;
  final String status;
  final int countMaxUsers;
  final String startTime;

  CreateEventPublicRequest({
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.number,
    required this.name,
    required this.lat,
    required this.long,
    required this.type,
    required this.description,
    required this.status,
    required this.countMaxUsers,
    required this.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'cidade': city,
      'bairro': neighborhood,
      'rua': street,
      'number': number,
      'name': name,
      'lat': lat,
      'long': long,
      'tipo': type,
      'descricao': description,
      'status': status,
      'qtd_max_user': countMaxUsers,
      'horario_de_inicio': startTime,
    };
  }

  String toJson() => json.encode(toMap());
}
