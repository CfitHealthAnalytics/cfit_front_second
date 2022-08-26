import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:flutter/material.dart';

class CalendarDetails extends StatelessWidget {
  const CalendarDetails({
    Key? key,
    required this.eventPublic,
  }) : super(key: key);
  final EventPublic eventPublic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                getDayByInt(
                  eventPublic.startTime.weekday,
                  abbreviation: true,
                ),
              ),
              const SizedBox(height: 4),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  eventPublic.startTime.day.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventPublic.startTime.getCustomHour(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: eventPublic.name.upperOnlyFirstLetter(),
                  children: [
                    const TextSpan(text: ' - '),
                    TextSpan(
                      text: eventPublic.neighborhood.upperOnlyFirstLetter(),
                    )
                  ],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              RichText(
                text: TextSpan(
                    text: eventPublic.usersCheckIn.length.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: '/',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: eventPublic.countMaxUsers.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
