import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/models/events.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/external/models/storage.dart';
import 'package:cfit/util/app_constants.dart';

class EventsRepositoryImpl implements EventsRepository {
  final ApiClient client;
  final Storage storage;
  EventsRepositoryImpl(
    this.client,
    this.storage,
  );

  @override
  Future<List<EventCityResponse>> getEventsPrivateInCity(
    EventCityRequest eventFilter,
  ) async {
    final response = await client.get(
      path: AppConstants.GET_HALL_EVENTS,
      query: {
        'initial_date': eventFilter.startTime!.toIso8601String(),
        'end_date': eventFilter.endTime!.toIso8601String(),
      },
    );
    return (response.data['responses'] as List)
        .map((response) => EventCityResponse.fromMap(response))
        .toList();
  }

  @override
  Future<bool> scheduleEvent(String eventId) async {
    final userId = await storage.get(AppConstants.USER_ID);

    await client.post(
      path: AppConstants.CONFIRMATION_HALL_EVENTS,
      query: {
        "id_event": eventId,
        "user": userId,
      },
      isBodyEmpty: true,
    );
    return true;
  }
}
