import 'package:cfit/data/entity/confirmation_event.dart';
import 'package:cfit/data/models/events.dart';

class DeclineEventPublicUseCase {
  final EventsRepository eventsRepository;

  DeclineEventPublicUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required List<String> usersConfirmed,
    required String eventId,
  }) async {
    await eventsRepository.declineUsersInEventPublic(
      ConfirmationEventCityRequest(
        eventId: eventId,
        usersConfirmed: usersConfirmed,
      ),
    );

    return true;
  }
}
