import 'dart:convert';

import 'package:cfit/domain/models/address.dart';

class SelectLocalizationResponse {
  final Address? address;
  final bool? createdEvent;
  final String? reason;
  
  SelectLocalizationResponse({
    this.address,
    this.createdEvent,
    this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
      'createdEvent': createdEvent,
      'reason': reason,
    };
  }

  factory SelectLocalizationResponse.fromMap(Map<String, dynamic> map) {
    return SelectLocalizationResponse(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      createdEvent: map['createdEvent'],
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectLocalizationResponse.fromJson(String source) =>
      SelectLocalizationResponse.fromMap(json.decode(source));
}
