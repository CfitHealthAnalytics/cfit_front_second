import 'dart:convert';

import 'package:cfit/domain/models/coordinates.dart';

class PolesResponse {
  final String name;
  final Coordinates coordinates;

  PolesResponse({
    required this.name,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'coordinates': coordinates.toMap(),
    };
  }

  factory PolesResponse.fromMap(Map<String, dynamic> map) {
    return PolesResponse(
      name: map['name'] ?? '',
      coordinates: Coordinates.fromMap(map['Coordinates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PolesResponse.fromJson(String source) =>
      PolesResponse.fromMap(json.decode(source));
}
