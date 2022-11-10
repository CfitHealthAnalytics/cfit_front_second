import 'package:cfit/data/entity/confirmation_event.dart';

import '../entity/events_city.dart';
import '../entity/events_public.dart';

abstract class EventsRepository {
  Future<List<EventCityResponse>> getEventsPrivateInCity(
    EventCityRequest eventFilter,
  );

  Future<List<EventPublicResponse>> getEventsPublic(DateTime date);

  Future<EventPublicResponse> getEventPublic(
    String eventId,
  );
  
  Future<bool> scheduleEventCity(
    String eventId,
  );

  Future<bool> unscheduleEventCity(
    String eventId,
  );

  Future<bool> scheduleEventPublic(
    String eventId,
  );

  Future<bool> unscheduleEventPublic(
    String eventId,
  );

  Future<bool> confirmUsersInEvent(
    ConfirmationEventCityRequest confirmationEvent,
  );
  
  Future<bool> confirmUsersInEventPublic(
    ConfirmationEventCityRequest confirmationEvent,
  );

  Future<bool> declineUsersInEventPublic(
    ConfirmationEventCityRequest confirmationEvent,
  );

  Future<bool> createEventPublic(
    CreateEventPublicRequest createEventPublicRequest,
    String userId,
  );

  Future<bool> editEventPublic(
    CreateEventPublicRequest createEventPublicRequest,
    String userId,
  );
  
  Future<bool> deleteEventPublic(
    String eventId,
    String userId,
  );

  Future<List<String>> getEventsCategories();
}
