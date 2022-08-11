import 'package:cfit/domain/erros/rules.dart';
import 'package:cfit/domain/models/feed.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/feed_use_case.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class HomeController {
  HomeController({
    required this.feedUseCase,
    required this.navigation,
  });
  final HomeNavigation navigation;
  final FeedUseCase feedUseCase;
  late final User _user;
  bool alreadyTried = false;
  User get user => _user;

  String get qrData =>
      'CF*${user.id}*${user.dateBirth.replaceAll('/', '')}*${user.gender.abbreviation()}';

  Future<Feed?> init() async {
    try {
      final feed = await feedUseCase();
      _user = feed.user;

      return feed;
    } on UnauthorizedException catch (_) {
      navigation.toLogin();
    } on NotLoggedUser catch (_) {
      navigation.toLogin();
    } catch (e) {
      if (alreadyTried == false) {
        alreadyTried = true;
        return await init();
      }
    }
    return null;
  }
}
