import 'package:cfit/data/models/events.dart';

class DeleteEventPublicUseCase {
  final EventsRepository eventsRepository;

  DeleteEventPublicUseCase({
    required this.eventsRepository,
  });

  Future<bool> call(eventId, userId) async {
    await eventsRepository.deleteEventPublic(eventId, userId);
    return true;
  }
}
