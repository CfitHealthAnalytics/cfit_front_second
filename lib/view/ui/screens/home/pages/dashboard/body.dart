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
                    if (state.feed!.user.isAdmin) {
                      navigation.toEventCityAdmin(
                        event,
                      );
                    } else {
                      navigation.toEventDetail(
                        event,
                        state.feed!.user,
                        alreadyConfirmed: event.usersCheckIn
                            .where((user) => user.id == state.feed!.user.id)
                            .isNotEmpty,
                      );
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
