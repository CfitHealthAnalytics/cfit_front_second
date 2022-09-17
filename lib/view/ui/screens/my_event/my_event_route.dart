import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_event_cubit.dart';
import 'my_event_navigation.dart';
import 'my_event_screen.dart';

class MyEventRoute extends StatelessWidget {
  const MyEventRoute({
    Key? key,
    required this.eventPublic,
    required this.user,
  }) : super(key: key);
  final EventPublic eventPublic;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyEventCubit(
        navigation: MyEventNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        event: eventPublic,
        user: user,
        getEventPublicUseCase: context.getEventPublicUseCase(),
        deleteEventPublicUseCase: context.deleteEventPublicUseCase(),
        confirmationEventPublicUseCase:
            context.confirmationEventPublicUseCase(),
        declineEventPublicUseCase: context.declineEventPublicUseCase(),
      ),
      child: MyEventScreen(
        user: user,
      ),
    );
  }
}
