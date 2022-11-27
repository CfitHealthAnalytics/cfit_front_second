import 'package:cfit/data/entity/pole.dart';
import 'package:cfit/data/models/pole.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/util/app_constants.dart';

class PoleRepositoryImpl implements PoleRepository {
  final ApiClient client;

  PoleRepositoryImpl({
    required this.client,
  });

  @override
  Future<List<PolesResponse>> getPoles() async {
    final response = await client.get(
      path: AppConstants.POLES,
    );

    return (response.data['responses'] as List)
        .map((pole) => PolesResponse.fromMap(pole))
        .toList();
  }
}
