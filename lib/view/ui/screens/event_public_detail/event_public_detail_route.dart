import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_public_detail_cubit.dart';
import 'event_public_detail_navigation.dart';
import 'event_public_detail_screen.dart';

class EventPublicDetailsRoute extends StatelessWidget {
  const EventPublicDetailsRoute({
    Key? key,
    required this.eventPublic,
    required this.user,
    required this.alreadyScheduled,
  }) : super(key: key);
  final EventPublic eventPublic;
  final User user;
  final bool alreadyScheduled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventPublicDetailsCubit(
        EventPublicDetailsNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        context.scheduleEventsPublicUseCase(),
        eventPublic,
        user,
        alreadyScheduled: alreadyScheduled,
      ),
      child: const EventPublicDetailsScreen(),
    );
  }
}
