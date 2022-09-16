import 'dart:convert';

import 'package:cfit/domain/models/address.dart';

class SelectLocalizationResponse {
  final Address? address;
  final bool? createdEvent;
  SelectLocalizationResponse({
    this.address,
    this.createdEvent,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
      'createdEvent': createdEvent,
    };
  }

  factory SelectLocalizationResponse.fromMap(Map<String, dynamic> map) {
    return SelectLocalizationResponse(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      createdEvent: map['createdEvent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectLocalizationResponse.fromJson(String source) =>
      SelectLocalizationResponse.fromMap(json.decode(source));
}
