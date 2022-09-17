import 'package:cfit/data/entity/confirmation_event.dart';
import 'package:cfit/data/models/events.dart';

class ConfirmationEventPublicUseCase {
  final EventsRepository eventsRepository;

  ConfirmationEventPublicUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required List<String> usersConfirmed,
    required String eventId,
  }) async {
    await eventsRepository.confirmUsersInEventPublic(
      ConfirmationEventCityRequest(
        eventId: eventId,
        usersConfirmed: usersConfirmed,
      ),
    );

    return true;
  }
}
