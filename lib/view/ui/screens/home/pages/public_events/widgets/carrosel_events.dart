import 'package:cfit/domain/models/events_public.dart';
import 'package:flutter/material.dart';

import 'public_event_card.dart';

class CarrosselEvents extends StatefulWidget {
  const CarrosselEvents({
    Key? key,
    required this.eventsPublic,
    required this.onTap,
  }) : super(key: key);
  final List<EventPublic> eventsPublic;
  final ValueSetter<EventPublic> onTap;
  @override
  State<CarrosselEvents> createState() => _CarrosselEventsState();
}

class _CarrosselEventsState extends State<CarrosselEvents> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                ),
                child: Container(
                  child: const Icon(Icons.arrow_back_ios),
                  padding: const EdgeInsets.all(8),
                ),
              ),
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.eventsPublic.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PublicEventCard(
                        eventPublic: widget.eventsPublic[index],
                        onTap: widget.onTap,
                      );
                    }),
              ),
              GestureDetector(
                onTap: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                ),
                child: Container(
                  child: const Icon(Icons.arrow_forward_ios),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
