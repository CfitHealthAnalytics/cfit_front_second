import 'package:cfit/data/models/pole.dart';
import 'package:cfit/domain/models/poles.dart';

class GetPolesUseCase {
  final PoleRepository poleRepository;

  GetPolesUseCase({
    required this.poleRepository,
  });

  Future<List<Pole>> call() async {
    final poles = await poleRepository.getPoles();

    return poles
        .map(
          (pole) => Pole(
            name: pole.name,
            coordinates: pole.coordinates,
          ),
        )
        .toList();
  }
}
