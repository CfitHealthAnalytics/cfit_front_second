import 'package:cfit/data/entity/confirmation_event.dart';
import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/entity/events_public.dart';
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
  Future<bool> scheduleEventCity(String eventId) async {
    final userId = await storage.get(AppConstants.USER_ID);

    await client.post(
      path: AppConstants.CHECKIN_CITY_EVENTS,
      query: {
        "id_event": eventId,
        "user": userId,
      },
      isBodyEmpty: true,
    );
    return true;
  }

  @override
  Future<bool> unscheduleEventCity(String eventId) async {
    final userId = await storage.get(AppConstants.USER_ID);

    await client.post(
      path: AppConstants.CHECKOUT_CITY_EVENTS,
      query: {
        "id_event": eventId,
        "user": userId,
      },
      isBodyEmpty: true,
    );
    return true;
  }

  @override
  Future<bool> scheduleEventPublic(String eventId) async {
    final userId = await storage.get(AppConstants.USER_ID);

    await client.post(
      path: AppConstants.CHECKIN_PUBLIC_EVENTS,
      query: {
        "id_event": eventId,
        "user": userId,
      },
      isBodyEmpty: true,
    );
    return true;
  }

  @override
  Future<bool> unscheduleEventPublic(String eventId) async {
    final userId = await storage.get(AppConstants.USER_ID);

    await client.post(
      path: AppConstants.CHECKOUT_PUBLIC_EVENTS,
      query: {
        "id_event": eventId,
        "user": userId,
      },
      isBodyEmpty: true,
    );
    return true;
  }

  @override
  Future<bool> confirmUsersInEvent(
      ConfirmationEventCityRequest confirmationEvent) async {
    await client.post(
      path: AppConstants.CONFIRMATION_HALL_EVENTS,
      query: {
        "id_event": confirmationEvent.eventId,
      },
      body: {
        'users_ids': confirmationEvent.usersConfirmed,
      },
    );
    return true;
  }

  @override
  Future<List<EventPublicResponse>> getEventsPublic(DateTime date) async {
    final response = await client.get(
      path: AppConstants.GET_PUBLIC_EVENTS,
      query: {
        'initial_date': date.toIso8601String(),
      },
    );
    final cleanList = (response.data['responses'] as List)
        .where((element) => element != null)
        .toList();
    // TODO: remove this when dont have events with user_checkin as string only
    cleanList.removeWhere((element) => element['user_create_info'] is String);

    return cleanList
        .map((response) => EventPublicResponse.fromMap(response))
        .toList();
  }

  @override
  Future<bool> createEventPublic(
    CreateEventPublicRequest createEventPublicRequest,
    String userId,
  ) async {
    final response = await client.post(
        path: AppConstants.REGISTER_EVENT,
        body: createEventPublicRequest.toMap(),
        query: {
          'user_id': userId,
        });

    return true;
  }

  @override
  Future<List<String>> getEventsCategories() async {
    final response = await client.get(
      path: AppConstants.GET_MODALIDADES_EVENTS,
    );

    final cleanList = (response.data['responses'] as List)
        .where((element) => element != null)
        .cast<String>()
        .toList();

    return cleanList;
  }

  @override
  Future<bool> editEventPublic(
    CreateEventPublicRequest createEventPublicRequest,
    String eventId,
  ) async {
    try {
      await client.post(
        path: '${AppConstants.EDIT_EVENT}/$eventId',
        body: createEventPublicRequest.toMap(),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<EventPublicResponse> getEventPublic(String eventId) async {
    final response = await client.get(
      path: AppConstants.GET_EVENT,
      query: {
        'event_id': eventId,
      },
    );

    return EventPublicResponse.fromMap(response.data);
  }

  @override
  Future<bool> deleteEventPublic(String eventId, String userId) async {
    await client.delete(
      path: "${AppConstants.DELETE_EVENT}/$eventId",
      query: {
        'user_id': userId,
      },
    );
    return true;
  }

  @override
  Future<bool> confirmUsersInEventPublic(
      ConfirmationEventCityRequest confirmationEvent) async {
    await client.post(
      path: AppConstants.CONFIRMATION_PUBLIC_EVENTS(confirmationEvent.eventId),
      body: {
        'users_ids': confirmationEvent.usersConfirmed,
      },
    );
    return true;
  }

  @override
  Future<bool> declineUsersInEventPublic(
      ConfirmationEventCityRequest confirmationEvent) async {
    await client.post(
      path: AppConstants.DECLINE_PUBLIC_EVENTS(confirmationEvent.eventId),
      body: {
        'users_ids': confirmationEvent.usersConfirmed,
      },
    );
    return true;
  }
}
