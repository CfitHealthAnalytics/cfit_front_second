import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_city.dart';

class ScheduleEventCityInCityUseCase {
  final EventsRepository eventsRepository;

  ScheduleEventCityInCityUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required EventCity event,
    bool unschedule = false,
  }) async {
    if (!unschedule) {
      await eventsRepository.scheduleEventCity(event.id);
    } else {
      await eventsRepository.unscheduleEventCity(event.id);
    }

    return true;
  }
}
