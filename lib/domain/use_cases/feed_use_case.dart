import 'package:cfit/data/models/user.dart';
import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';

class FeedUseCase {
  final UserRepository userRepository;
  final void Function(User) setUser;

  FeedUseCase({
    required this.userRepository,
    required this.setUser,
  });

  Future<User> getUser() async {
    final isConectaUser = await userRepository.isConectaUser();

    if (isConectaUser) {
      final userResponse = await userRepository.getUserInStorage();

      final _user = User(
        id: userResponse.id,
        name: userResponse.name,
        email: userResponse.email,
        dateBirth: userResponse.dateBirth,
        gender: userResponse.gender.toGender(),
        isAdmin: false,
        fromConecta: isConectaUser,
      );
      setUser(_user);

      return _user;
    }

    final userResponse = await userRepository.getUser();
    final listAdmin = await userRepository.getAdmins();
    final _user = User(
      id: userResponse.id,
      name: userResponse.name,
      email: userResponse.email,
      dateBirth: userResponse.dateBirth,
      gender: userResponse.gender.toGender(),
      isAdmin: listAdmin.contains(userResponse.id),
    );

    setUser(_user);

    return _user;
  }

  Future<List<EventCity>?> getGymCityEvents() async {
    final userEvents = await userRepository.getUserEventsCity();
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

  Future<List<EventPublic>?> getPublicEvents() async {
    final userEvents = await userRepository.getUserEventsPublic();
    List<EventPublic>? confirmedEvents;
    if (userEvents != null) {
      confirmedEvents = userEvents
          .map(
            (event) => EventPublic(
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
            ),
          )
          .toList();
    }
    return confirmedEvents;
  }

  Future<List<EventPublic>?> getMyEvents() async {
    final userEvents = await userRepository.getUserEventsCreator();
    if (userEvents == null) {
      return [];
    }
    List<EventPublic>? confirmedEvents;
    confirmedEvents = userEvents
        .map(
          (event) => EventPublic(
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
          ),
        )
        .toList();
    return confirmedEvents;
  }
}
