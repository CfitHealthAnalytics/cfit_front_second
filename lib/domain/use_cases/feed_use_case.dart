import 'package:cfit/data/models/user.dart';
import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/domain/models/user.dart';

class FeedUseCase {
  final UserRepository userRepository;

  FeedUseCase({
    required this.userRepository,
  });

  Future<Feed> call() async {
    final userResponse = await userRepository.getUser();

    return Feed(
      user: User(
        name: userResponse.name,
        email: userResponse.email,
        dateBirth: userResponse.dateBirth,
        gender: userResponse.gender.toGender(),
      ),
    );
  }
}
