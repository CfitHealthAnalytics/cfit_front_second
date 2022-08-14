import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:flutter/material.dart';

import 'navigation.dart';

class BodyGym extends StatefulWidget {
  const BodyGym({
    Key? key,
    required this.getEventsCity,
    required this.navigation,
  }) : super(key: key);

  final Future<List<EventCity>> Function({
    DateTime? endTime,
    required DateTime startTime,
  }) getEventsCity;
  final GymNavigation navigation;

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
    return Column(
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
          onPressed: (event) => widget.navigation.toEventDetail(
            event,
          ),
        )
      ],
    );
  }
}

class ResultsEvents extends StatelessWidget {
  const ResultsEvents({
    super.key,
    required this.getEventsCity,
    required this.selectedDate,
    required this.onPressed,
  });

  final Future<List<EventCity>> Function({
    DateTime? endTime,
    required DateTime startTime,
  }) getEventsCity;

  final DateTime selectedDate;
  final void Function(EventCity) onPressed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventCity>>(
        future: getEventsCity(
          startTime: selectedDate,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingEventsCity();
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Expanded(
              child: Center(
                child: Text(
                  'Não temos eventos para este dia',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }

          return Expanded(
            child: ListEventCity(
              onPressed: onPressed,
              events: snapshot.data!,
            ),
          );
        });
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
    return ListView(
      children: events
          .map(
            (event) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: ListTile(
                tileColor: Colors.white,
                title: Container(
                  child: Text(
                    event.type.upperOnlyFirstLetter(),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 105,
                  child: Container(
                    color: Colors.white,
                    width: 95,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${event.startTime.getCustomHour()} h',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              event.startTime.getCustomDate(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                trailing: SizedBox(
                  width: 105,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      RichText(
                        text: TextSpan(
                            text: event.usersConfirmation.length.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: '/',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: event.countMaxUsers.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
                onTap: () => onPressed(event),
              ),
            ),
          )
          .toList(),
    );
  }
}

class CalendarShort extends StatefulWidget {
  const CalendarShort({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final ValueChanged<DateTime> onChange;
  @override
  State<CalendarShort> createState() => _CalendarShortState();
}

class _CalendarShortState extends State<CalendarShort> {
  late DateTime date;
  late DateTime selectedDate;
  late List<DateTime> arrayDate;
  @override
  void initState() {
    date = DateTime.now();
    selectedDate = date;
    arrayDate = buildArrayDate(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: getMonthByInt(date.month),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: date.year.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.subtract(const Duration(days: 7));
                        arrayDate = buildArrayDate(date);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.add(const Duration(days: 7));
                        arrayDate = buildArrayDate(date);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: arrayDate
                .map(
                  (dateItem) => Column(
                    children: [
                      Text(
                        getDayByInt(
                          dateItem.weekday,
                          abbreviation: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DateCalendarShort(
                        date: dateItem,
                        isCurrentDate: selectedDate == dateItem,
                        pastDate: dateItem.compareTo(DateTime.now()) < 0,
                        onChange: (datePressed) {
                          setState(() {
                            selectedDate = datePressed;
                          });
                          widget.onChange(datePressed);
                        },
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class DateCalendarShort extends StatelessWidget {
  const DateCalendarShort({
    Key? key,
    required this.date,
    required this.isCurrentDate,
    required this.pastDate,
    required this.onChange,
  }) : super(key: key);

  final DateTime date;
  final bool isCurrentDate;
  final bool pastDate;
  final ValueChanged<DateTime> onChange;

  Color getColorText() {
    if (isCurrentDate) {
      return Colors.white;
    }
    return pastDate ? Colors.grey : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(date),
      child: CircleAvatar(
        backgroundColor: pastDate ? Colors.grey : Colors.black,
        radius: 20,
        child: CircleAvatar(
          backgroundColor:
              isCurrentDate ? Theme.of(context).primaryColor : Colors.white,
          radius: isCurrentDate ? 20 : 19,
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: getColorText(),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
