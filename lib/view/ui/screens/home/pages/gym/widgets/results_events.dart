import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:flutter/material.dart';

import 'list_events.dart';

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
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return Expanded(
            child: ListEventCity(
              onPressed: onPressed,
              events: snapshot.data!,
              onRefresh: () {
                return getEventsCity(
                  startTime: selectedDate,
                );
              },
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
