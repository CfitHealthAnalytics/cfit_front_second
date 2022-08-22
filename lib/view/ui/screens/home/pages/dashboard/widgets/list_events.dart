import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:flutter/material.dart';

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
