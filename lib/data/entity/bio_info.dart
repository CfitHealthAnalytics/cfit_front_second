import 'dart:convert';

class BioInfoResponse {
  final double pulse;
  final double height;
  final double weight;
  final double imc;
  final double igp;
  BioInfoResponse({
    required this.pulse,
    required this.height,
    required this.weight,
    required this.imc,
    required this.igp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pulse': pulse,
      'height': height,
      'weight': weight,
      'imc': imc,
      'igp': igp,
    };
  }

  factory BioInfoResponse.fromMap(Map<String, dynamic> map) {
    return BioInfoResponse(
      pulse: double.tryParse(map['pulse']) ?? 0.0,
      height: double.tryParse(map['height']) ?? 0.0,
      weight: double.tryParse(map['weight']) ?? 0.0,
      imc: double.tryParse(map['imc']) ?? 0.0,
      igp: double.tryParse(map['igp']) ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BioInfoResponse.fromJson(String source) =>
      BioInfoResponse.fromMap(json.decode(source));
}
