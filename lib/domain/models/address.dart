import 'coordinates.dart';

class Address {
  final String street;
  final String neighborhood;
  final String number;
  final String city;
  final Coordinates coordinates;

  Address({
    this.street = '',
    this.neighborhood = '',
    this.number = '',
    this.city = '',
    required this.coordinates,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.street == street &&
        other.neighborhood == neighborhood &&
        other.number == number &&
        other.city == city &&
        other.coordinates == coordinates;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        neighborhood.hashCode ^
        number.hashCode ^
        city.hashCode ^
        coordinates.hashCode;
  }

  String? get formattedAddress =>
      (street != '' && number != '' && neighborhood != '')
          ? '$street, $number - $neighborhood'
          : null;

  Address copyWith({
    String? street,
    String? neighborhood,
    String? number,
    String? city,
    Coordinates? coordinates,
  }) {
    return Address(
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      city: city ?? this.city,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
