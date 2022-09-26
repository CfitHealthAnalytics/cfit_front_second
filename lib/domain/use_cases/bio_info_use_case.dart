import 'package:cfit/data/models/bio.dart';
import 'package:cfit/domain/models/bio_info.dart';

class BioInfoUseCase {
  final BioInfoRepository bioInfoRepository;

  BioInfoUseCase({
    required this.bioInfoRepository,
  });

  Future<BioInfo?> getBioInfo(String userId) async {
    try {
      final response = await bioInfoRepository.getCurrentBioInfo(userId);
      return BioInfo(
        pulse: response.pulse,
        height: response.height,
        weight: response.weight,
        imc: response.imc,
        igp: response.igp,
        date: response.date,
      );
    } catch (e) {
      return null;
    }
  }

  Future<Map<DateTime, double>?> getChartData(String userId) async {
    try {
      return await bioInfoRepository.getIGPbyTime(userId);
    } catch (e) {
      return null;
    }
  }
}
