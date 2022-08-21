import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';

class Feed {
  final User user;
  final List<EventCity>? confirmedEvents;

  Feed({
    required this.user,
    this.confirmedEvents,
  });
}
