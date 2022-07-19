import 'dart:ui';

import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsCityItem extends StatefulWidget {
  const EventsCityItem(
      {Key? key,
      required this.job,
      required this.eventC,
      this.showTime = false})
      : super(key: key);

  final EventsController eventC;
  final EventsModel job;
  final bool showTime;

  @override
  State<EventsCityItem> createState() => _EventsCityItemState();
}

class _EventsCityItemState extends State<EventsCityItem> {
  @override
  Widget build(BuildContext context) {
    int UserConfirm = widget.job.users_confirmation!.toList().length;
    int UserTotal = widget.job.users_checkin!.toList().length;

    String idUser = Get.find<UserController>().idLocal;

    List<String> array1 = [];
    List<String> busca = [idUser];

    bool exists = false;
    if (widget.job.users_confirmation!.isNotEmpty) {
      for (var v in widget.job.users_confirmation!) {
        if (v == idUser) {
          exists = true;
        }
      }
    }

    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: EventDetail(widget.job, widget.eventC, 1),
          ),
        )
      },
      child: Container(
        width: 270,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(30),
          //borderRadius: BorderRadius.all(230),
          border: Border(
            top: BorderSide(
              width: 1,
              color: Color(0xffBEBAB3),
              style: BorderStyle.solid,
            ),
            bottom: BorderSide(
              width: 1,
              color: Color(0xffBEBAB3),
              style: BorderStyle.solid,
            ),
            left: BorderSide(
              width: 6,
              color: Color(0xff002A51),
              style: BorderStyle.solid,
            ),
            right: BorderSide(
              width: 1,
              color: Color(0xffBEBAB3),
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '07:30 h',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text('04/06'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.job.nome ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          UserConfirm.toString() + '/' + UserTotal.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
