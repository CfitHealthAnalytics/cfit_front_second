import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_city.dart';

class ScheduleEventInCityUseCase {
  final EventsRepository eventsRepository;

  ScheduleEventInCityUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required EventCity event,
    bool unschedule = false,
  }) async {
    if (!unschedule) {
      await eventsRepository.scheduleEvent(event.id);
    } else {
      await eventsRepository.unscheduleEvent(event.id);
    }

    return true;
  }
}
