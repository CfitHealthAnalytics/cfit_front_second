import 'package:cfit/data/entity/events_city.dart';
import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_city.dart';

import '../models/user.dart';

class EventsInCityUseCase {
  final EventsRepository eventsRepository;

  EventsInCityUseCase({
    required this.eventsRepository,
  });

  Future<List<EventCity>> call({
    required DateTime startTime,
    required DateTime endTime,
    required String pole,
  }) async {
    final eventList =
        await eventsRepository.getEventsPrivateInCity(EventCityRequest(
      startTime: startTime,
      endTime: endTime,
      pole: pole
    ));

    return eventList
        .map(
          (event) => EventCity(
            street: event.street,
            neighborhood: event.neighborhood,
            number: event.number,
            startTime: DateTime.parse(event.startTime),
            type: event.type,
            countUsers: event.countUsers,
            usersCheckIn: event.usersCheckIn
                .map(
                  (user) => User.fromMap(
                    user.toMap(),
                  ),
                )
                .toList(),
            usersConfirmation: event.usersConfirmation,
            description: event.description,
            city: event.city,
            coordinates: event.coordinates,
            createdAt: DateTime.parse(event.createdAt),
            name: event.name,
            countMaxUsers: event.countMaxUsers,
            id: event.id,
          ),
        )
        .toList();
  }
}
