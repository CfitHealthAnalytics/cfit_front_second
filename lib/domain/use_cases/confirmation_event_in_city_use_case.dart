import 'package:cfit/data/entity/confirmation_event.dart';
import 'package:cfit/data/models/events.dart';

class ConfirmationEventInCityUseCase {
  final EventsRepository eventsRepository;

  ConfirmationEventInCityUseCase({
    required this.eventsRepository,
  });

  Future<bool> call({
    required List<String> usersConfirmed,
    required String eventId,
  }) async {
    await eventsRepository.confirmUsersInEvent(
      ConfirmationEventCityRequest(
        eventId: eventId,
        usersConfirmed: usersConfirmed,
      ),
    );

    return true;
  }
}
