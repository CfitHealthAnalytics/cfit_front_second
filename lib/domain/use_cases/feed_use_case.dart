import 'package:cfit/data/models/user.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';

class FeedUseCase {
  final UserRepository userRepository;

  FeedUseCase({
    required this.userRepository,
  });

  Future<User> getUser() async {
    final userResponse = await userRepository.getUser();
    final listAdmin = await userRepository.getAdmins();
    return User(
        id: userResponse.id,
        name: userResponse.name,
        email: userResponse.email,
        dateBirth: userResponse.dateBirth,
        gender: userResponse.gender.toGender(),
        isAdmin: listAdmin.contains(userResponse.id));
  }

  Future<List<EventCity>?> getConfirmedEvents() async {
    final userEvents = await userRepository.getUserEvents();
    List<EventCity>? confirmedEvents;
    if (userEvents != null) {
      confirmedEvents = userEvents
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
    return confirmedEvents;
  }
}
