import 'package:cfit/data/models/bio.dart';
import 'package:cfit/domain/models/bio_info.dart';

class BioInfoUseCase {
  final BioInfoRepository bioInfoRepository;

  BioInfoUseCase({
    required this.bioInfoRepository,
  });

  Future<BioInfo> getBioInfo(String userId) async {
    final response = await bioInfoRepository.getCurrentBioInfo(userId);
    return BioInfo(
      pulse: response.pulse,
      height: response.height,
      weight: response.weight,
      imc: response.imc,
      igp: response.igp,
    );
  }

  Future<Map<DateTime, double>> getChartData(String userId) async {
    return await bioInfoRepository.getIGPbyTime(userId);
  }
}
