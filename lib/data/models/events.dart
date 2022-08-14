import '../entity/events_city.dart';

abstract class EventsRepository {
  Future<List<EventCityResponse>> getEventsPrivateInCity(
    EventCityRequest eventFilter,
  );

  Future<bool> scheduleEvent(
    String eventId,
  );
}
