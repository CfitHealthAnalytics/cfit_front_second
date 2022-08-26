import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_public.dart';

class ScheduleEventPublicInCityUseCase {
  final EventsRepository eventsRepository;

  ScheduleEventPublicInCityUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required EventPublic event,
    bool unschedule = false,
  }) async {
    if (!unschedule) {
      await eventsRepository.scheduleEventPublic(event.id);
    } else {
      await eventsRepository.unscheduleEventPublic(event.id);
    }

    return true;
  }
}
