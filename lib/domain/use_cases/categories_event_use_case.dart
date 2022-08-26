import 'package:cfit/data/models/events.dart';

class CategoriesEventUseCase {
  final EventsRepository eventsRepository;

  CategoriesEventUseCase({
    required this.eventsRepository,
  });

  Future<List<String>> call() async {
    try {
      return await eventsRepository.getEventsCategories();
    } catch (e) {
      return [];
    }
  }
}
