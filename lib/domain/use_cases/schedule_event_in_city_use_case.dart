import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_city.dart';

class ScheduleEventInCityUseCase {
  final EventsRepository eventsRepository;

  ScheduleEventInCityUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required EventCity event,
  }) async {
    await eventsRepository.scheduleEvent(event.id);

    return true;
  }
}
