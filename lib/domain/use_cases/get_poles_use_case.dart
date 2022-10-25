import 'package:cfit/data/models/pole.dart';
import 'package:cfit/domain/models/poles.dart';

class GetPolesUseCase {
  final PoleRepository poleRepository;

  GetPolesUseCase({
    required this.poleRepository,
  });

  Future<List<Pole>> call() async {
    print('antes de chamar o repositorio');
    final poles = await poleRepository.getPoles();
    print('depois de chamar o repositorio');
    print('poles: $poles');

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
