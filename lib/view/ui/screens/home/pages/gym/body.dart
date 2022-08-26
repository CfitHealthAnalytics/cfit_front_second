import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'widgets/widgets.dart';

class BodyGym extends StatefulWidget {
  const BodyGym({
    Key? key,
    required this.getEventsCity,
    required this.user,
    required this.navigation,
  }) : super(key: key);

  final Future<List<EventCity>> Function({
    DateTime? endTime,
    required DateTime startTime,
  }) getEventsCity;
  final HomeNavigation navigation;
  final User user;

  @override
  State<BodyGym> createState() => _BodyGymState();
}

class _BodyGymState extends State<BodyGym> {
  late DateTime selectedDate;
  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return VisibilityDetector(
      key: const Key('gym-resuts'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > 0 && !cubit.alreadyLoaded) {
          cubit.setAlreadyLoaded();
          widget.getEventsCity(
            startTime: selectedDate,
          );
        } else {
          cubit.setNotAlreadyLoaded();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: CalendarShort(
              onChange: (newSelectedDate) {
                setState(() {
                  selectedDate = newSelectedDate;
                });
              },
            ),
          ),
          Container(
            color: Colors.white,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: const Text(
              'Resultados',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ResultsEvents(
            getEventsCity: widget.getEventsCity,
            selectedDate: selectedDate,
            onPressed: (event) {
              cubit.setNotAlreadyLoaded();
              if (widget.user.isAdmin) {
                widget.navigation.toEventCityAdmin(
                  event,
                );
              } else {
                widget.navigation.toEventCityDetail(
                  event,
                  widget.user,
                  alreadyConfirmed: event.usersCheckIn
                      .where((user) => user.id == widget.user.id)
                      .isNotEmpty,
                );
              }
            },
          )
        ],
      ),
    );
  }
}

