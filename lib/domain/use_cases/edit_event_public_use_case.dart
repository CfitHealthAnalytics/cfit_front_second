import 'package:cfit/data/entity/events_public.dart';
import 'package:cfit/data/models/events.dart';
import 'package:cfit/domain/models/address.dart';

class EditEventPublicUseCase {
  final EventsRepository _eventRepository;

  EditEventPublicUseCase(
    this._eventRepository,
  );

  Future<bool> call({
    required String name,
    required String description,
    required String type,
    required Address address,
    required int countMax,
    required DateTime date,
    required String eventId,
  }) async {
    return await _eventRepository.editEventPublic(
      CreateEventPublicRequest(
        city: address.city,
        neighborhood: address.neighborhood,
        street: address.street,
        number: address.number,
        name: name,
        lat: address.coordinates.lat!,
        long: address.coordinates.long!,
        type: type,
        description: description,
        status: "true",
        countMaxUsers: countMax,
        startTime: date.toIso8601String(),
      ),
      eventId,
    );
  }
}
