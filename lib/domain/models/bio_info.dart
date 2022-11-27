
class BioInfo {
  final double pulse;
  final double height;
  final double weight;
  final double imc;
  final double igp;
  final DateTime date;

  BioInfo({
    required this.pulse,
    required this.height,
    required this.weight,
    required this.imc,
    required this.igp,
    required this.date,
  });
  
  @override
  String toString() {
    return 'BioInfo(pulse: $pulse, height: $height, weight: $weight, imc: $imc, igp: $igp, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BioInfo &&
        other.pulse == pulse &&
        other.height == height &&
        other.weight == weight &&
        other.imc == imc &&
        other.igp == igp &&
        other.date == date;
  }

  @override
  int get hashCode {
    return pulse.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        imc.hashCode ^
        igp.hashCode ^
        date.hashCode;
  }
}
