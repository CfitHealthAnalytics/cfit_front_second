import 'package:cfit/data/entity/confirmation_event.dart';

import '../entity/events_city.dart';

abstract class EventsRepository {
  Future<List<EventCityResponse>> getEventsPrivateInCity(
    EventCityRequest eventFilter,
  );

  Future<bool> scheduleEvent(
    String eventId,
  );
  
  Future<bool> unscheduleEvent(
    String eventId,
  );

  Future<bool> confirmUsersInEvent(
    ConfirmationEventCityRequest confirmationEvent,
  );
}
