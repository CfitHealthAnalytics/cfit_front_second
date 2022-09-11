import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class BodyDashboard extends StatelessWidget {
  const BodyDashboard({
    Key? key,
    required this.navigation,
  }) : super(key: key);

  final HomeNavigation navigation;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (oldState, newState) =>
          (oldState.loadingRequestGetEvents !=
              newState.loadingRequestGetEvents) ||
          (oldState.filter != newState.filter),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Meus eventos',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const FiltersDashboard(),
            if (state.loadingRequestGetEvents)
              const LoadingEventsCity()
            else
              Expanded(
                child: ListEventCity(
                  events: state.events,
                  onPressed: (event) {
                    cubit.setNotAlreadyLoaded();
                    if (state.feed!.user.isAdmin) {
                      if (event is EventCity) {
                        navigation.toEventCityAdmin(
                          event,
                        );
                      }
                    } else {
                      if (event is EventCity) {
                        navigation.toEventCityDetail(
                          event,
                          state.feed!.user,
                          alreadyConfirmed: event.usersCheckIn
                              .where((user) => user.id == state.feed!.user.id)
                              .isNotEmpty,
                        );
                      } else {
                        if ((event as EventPublic).userCreator.id ==
                            state.feed!.user.id) {
                          navigation.toEventPublicAdmin(
                            event,
                            state.feed!.user,
                          );
                        }
                      }
                    }
                  },
                ),
              )
          ],
        );
      },
    );
  }
}
