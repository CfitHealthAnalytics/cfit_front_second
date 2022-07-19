import 'dart:ui';

import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:cfit/view/ui/screens/events/widgets/events_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventItem extends StatefulWidget {
  const EventItem(
      {Key? key,
      required this.eventController,
      required this.evento,
      this.showTime = false})
      : super(key: key);

  final EventsController eventController;
  final EventsModel evento;
  final bool showTime;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    String idUser = Get.find<UserController>().idLocal;

    List<String> array1 = [];
    List<String> busca = [idUser];

    bool exists = false;

    if (widget.evento.users_confirmation!.isNotEmpty) {
      for (var v in widget.evento.users_confirmation!) {
        if (v == idUser) {
          exists = true;
        }
      }
    }
    return Container(
      width: (Get.width * 0.9),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff000000),
        ),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          child: Column(children: <Widget>[
            //Show Weekday, Month and day of Appiontment
            Text(' ',
                style: TextStyle(
                  color: Colors.blue.withOpacity(1.0),
                  fontWeight: FontWeight.bold,
                  height: 0.4,
                )),
            //Show Start Time of Appointment
            const Text('07:30 h',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                )),
            //Show End Time of Appointment
            Text(
              '04/06',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ]),
        ), //Text(DateFormat.Hm().format(event.date)),//DateFormat.Hm().format(now)
        title: Row(
          children: [
            Text(widget.evento.nome ?? ' '),
          ],
        ),

        trailing: exists == true
            ? Column(children: const <Widget>[
                //event.status=='CONFIRMED' ?
                Icon(Icons.error,
                    color: Colors.pink,
                    //size:25.0,
                    semanticLabel:
                        'Unconfirmed Appointment'), //:Container(width:0,height:0),
                Icon(Icons.arrow_right),
              ])
            : const Icon(Icons.arrow_right),
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: EventDetail(widget.evento, widget.eventController, 0),
            ),
          );
        },
      ),
    );
  }
}
