import 'package:cfit/data/entity/bio_info.dart';

abstract class BioInfoRepository {
  Future<List<BioInfoResponse>> getCurrentBioInfo(String userId);

  Future<Map<DateTime, double>> getIGPbyTime(String userId);
}
