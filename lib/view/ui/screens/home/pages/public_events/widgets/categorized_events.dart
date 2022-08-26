import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

import 'public_event_card.dart';

class CategorizedEvents extends StatelessWidget {
  const CategorizedEvents({
    Key? key,
    required this.categorizedEvents,
    required this.onTap,
  }) : super(key: key);
  final Map<String, List<EventPublic>> categorizedEvents;
  final ValueSetter<EventPublic> onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: categorizedEvents.entries
          .map((category) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.key.upperOnlyFirstLetter(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ).withPaddingSymmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: category.value
                          .map(
                            (eventPublic) => PublicEventCard(
                              eventPublic: eventPublic,
                              onTap: onTap,
                            ).withPaddingSymmetric(horizontal: 16),
                          )
                          .toList(),
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }
}
