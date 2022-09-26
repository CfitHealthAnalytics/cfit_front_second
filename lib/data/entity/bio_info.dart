import 'dart:convert';

class BioInfoResponse {
  final double pulse;
  final double height;
  final double weight;
  final double imc;
  final double igp;
  final DateTime date;
  BioInfoResponse({
    required this.pulse,
    required this.height,
    required this.weight,
    required this.imc,
    required this.igp,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'pulse': pulse,
      'height': height,
      'weight': weight,
      'imc': imc,
      'igp': igp,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory BioInfoResponse.fromMap(Map<String, dynamic> map) {
    return BioInfoResponse(
      pulse: double.tryParse(map['pulso']) ?? 0.0,
      height: double.tryParse(map['altura']) ?? 0.0,
      weight: double.tryParse(map['peso']) ?? 0.0,
      imc: double.tryParse(map['imc']) ?? 0.0,
      igp: double.tryParse(map['igp']) ?? 0.0,
      date: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BioInfoResponse.fromJson(String source) =>
      BioInfoResponse.fromMap(json.decode(source));
}
