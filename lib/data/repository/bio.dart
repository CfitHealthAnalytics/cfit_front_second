import 'package:cfit/data/entity/bio_info.dart';
import 'package:cfit/data/models/bio.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/util/app_constants.dart';

class BioInfoRepositoryImpl implements BioInfoRepository {
  final ApiClient client;

  BioInfoRepositoryImpl(
    this.client,
  );

  @override
  Future<BioInfoResponse> getCurrentBioInfo(String userId) async {
    final response = await client.get(
      path: '${AppConstants.GET_BIO_INFO}/$userId',
    );
    late final Map<String, dynamic> result;

    response.data.forEach((key, _) {
      result = response.data[key];
    });

    return BioInfoResponse.fromMap(result);
  }

  @override
  Future<Map<DateTime, double>> getIGPbyTime(String userId) async {
    final response = await client.get(
      path: '${AppConstants.GET_IGP_BY_DATE_URI}/$userId',
    );
    final map = response.data;
    final renewMap = <DateTime, double>{};

    map['datetime']!.forEach((key, value) {
      renewMap.addAll({DateTime.parse(value): double.parse(map['igp']![key]!)});
    });

    return renewMap;
  }
}
