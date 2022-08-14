import 'dart:convert';

class Coordinates {
  double? lat;
  double? long;

  Coordinates({
    this.lat,
    this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': lat,
      'longitude': long,
    };
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: map['latitude']?.toDouble(),
      long: map['longitude']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinates.fromJson(String source) =>
      Coordinates.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coordinates && other.lat == lat && other.long == long;
  }

  @override
  int get hashCode => lat.hashCode ^ long.hashCode;
}
