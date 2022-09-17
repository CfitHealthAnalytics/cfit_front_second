import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/events_public.dart';

import '../models/user.dart';

class GetEventPublicUseCase {
  final EventsRepository eventsRepository;

  GetEventPublicUseCase({
    required this.eventsRepository,
  });

  Future<EventPublic> call(eventId) async {
    final event = await eventsRepository.getEventPublic(eventId);

    return EventPublic(
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
      usersRejection: event.usersRejection,
      description: event.description,
      city: event.city,
      coordinates: event.coordinates,
      createdAt: DateTime.parse(event.createdAt),
      name: event.name,
      countMaxUsers: event.countMaxUsers,
      id: event.id,
      status: event.status,
      usersLike: event.usersLike,
      userCreator: User.fromMap(
        event.userCreator.toMap(),
      ),
    );
  }
}
