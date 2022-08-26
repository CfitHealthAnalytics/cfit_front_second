import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/extentions.dart';
import 'package:flutter/material.dart';

class ListEventCity extends StatelessWidget {
  const ListEventCity({
    Key? key,
    required this.onPressed,
    required this.onRefresh,
    required this.events,
  }) : super(key: key);

  final void Function(EventCity event) onPressed;
  final Future<void> Function() onRefresh;
  final List<EventCity> events;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
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
                      event.name.upperOnlyFirstLetter(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
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
                                event.startTime.getCustomHour(),
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
                              text: event.usersCheckIn.length.toString(),
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
      ),
    );
  }
}
