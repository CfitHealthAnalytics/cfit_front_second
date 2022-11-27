import 'package:cfit/data/models/bio.dart';
import 'package:cfit/domain/models/bio_info.dart';

class BioInfoUseCase {
  final BioInfoRepository bioInfoRepository;

  BioInfoUseCase({
    required this.bioInfoRepository,
  });

  Future<List<BioInfo>> _getBioInfos(String userId) async {
    final response = await bioInfoRepository.getCurrentBioInfo(userId);
    final infos = response
        .map(
          (element) => BioInfo(
            pulse: element.pulse,
            height: element.height,
            weight: element.weight,
            imc: element.imc,
            igp: element.igp,
            date: element.date,
          ),
        )
        .toList();
    infos.sort((first, second) => second.date.compareTo(first.date));
    return infos;
  }

  Future<BioInfo?> getBioInfo(String userId) async {
    try {
      final infos = await _getBioInfos(userId);
      final lasted = infos.first;

      return BioInfo(
        pulse: lasted.pulse,
        height: lasted.height,
        weight: lasted.weight,
        imc: lasted.imc,
        igp: lasted.igp,
        date: lasted.date,
      );
    } catch (e) {
      return null;
    }
  }

  Future<Map<DateTime, double>?> getChartData(String userId) async {
    try {
      final infos = await _getBioInfos(userId);

      Map<DateTime, double> map = <DateTime, double>{};

      for (var element in infos) {
        map.addAll({element.date: element.igp});
      }
      return map;
    } catch (e) {
      return null;
    }
  }
}
