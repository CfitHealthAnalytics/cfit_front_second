import '../entity/pole.dart';

abstract class PoleRepository {
  Future<List<PolesResponse>> getPoles();
}
