import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:cfit/view/ui/screens/home/home_navigation.dart';
import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          oldState.loadingRequestGetEvents != newState.loadingRequestGetEvents,
      builder: (context, state) {
        if (state.loadingRequestGetEvents) {
          return const LoadingEventsCity();
        }
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
            SizedBox(
              height: 32,
              child: Row(
                children: [
                  const Text(
                    'Filtros: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ).withPaddingOnly(
                    left: 16.0,
                    right: 8.0,
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ChipCFit(
                          label: 'Todos',
                          onPressed: cubit.setFilterDashboard,
                          isSelected: state.filter == HomeStateEventsFilter.all,
                          value: HomeStateEventsFilter.all,
                        ).withPaddingSymmetric(horizontal: 4.0),
                        ChipCFit(
                          label: 'Criados por mim',
                          onPressed: cubit.setFilterDashboard,
                          isSelected: state.filter == HomeStateEventsFilter.my,
                          value: HomeStateEventsFilter.my,
                        ).withPaddingSymmetric(horizontal: 4.0),
                        ChipCFit(
                          label: 'Academia Recife',
                          onPressed: cubit.setFilterDashboard,
                          isSelected:
                              state.filter == HomeStateEventsFilter.gymCity,
                          value: HomeStateEventsFilter.gymCity,
                        ).withPaddingSymmetric(horizontal: 4.0),
                        ChipCFit(
                          label: 'Público',
                          onPressed: cubit.setFilterDashboard,
                          isSelected:
                              state.filter == HomeStateEventsFilter.public,
                          value: HomeStateEventsFilter.public,
                        ).withPaddingSymmetric(horizontal: 4.0),
                      ],
                    ),
                  ),
                ],
              ),
            ).withPaddingSymmetric(vertical: 8),
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

class ChipCFit extends StatelessWidget {
  const ChipCFit({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final void Function(HomeStateEventsFilter filter) onPressed;
  final HomeStateEventsFilter value;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorDark,
      onPressed: () => onPressed(value),
    );
  }
}

class ListEventCity extends StatelessWidget {
  const ListEventCity({
    Key? key,
    required this.onPressed,
    required this.events,
  }) : super(key: key);

  final void Function(EventCity event) onPressed;
  final List<EventCity> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'No momento, você não tem nenhum evento',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: events
            .map(
              (event) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10,
                ),
                child: InkWell(
                  onTap: () => onPressed(event),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getDayByInt(
                                            event.startTime.weekday,
                                            abbreviation: true,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            event.startTime.day.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.startTime.getCustomHour(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: event.type.upperOnlyFirstLetter(),
                                    children: [
                                      const TextSpan(text: ' - '),
                                      TextSpan(
                                        text: event.neighborhood
                                            .upperOnlyFirstLetter(),
                                      ),
                                    ],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class LoadingEventsCity extends StatelessWidget {
  const LoadingEventsCity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            const SizedBox(height: 16),
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: 16),
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            const SizedBox(height: 16),
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(height: 16),
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.35,
            ),
            const SizedBox(height: 16),
            LoadingBox(
              height: 40,
              customWidth: MediaQuery.of(context).size.width * 0.35,
            )
          ],
        ),
      ),
    );
  }
}
