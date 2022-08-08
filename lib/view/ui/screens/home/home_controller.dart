import 'package:cfit/domain/erros/rules.dart';
import 'package:cfit/domain/models/feed.dart';
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

  Future<Feed?> init() async {
    try {
      return await feedUseCase();
    } on UnauthorizedException catch (_) {
      navigation.toLogin();
    } on NotLoggedUser catch (_) {
      navigation.toLogin();
    }
    return null;
  }
}
