import 'package:cfit/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsAppBar extends StatefulWidget {
  const EventsAppBar({Key? key}) : super(key: key);

  @override
  _EventsAppBarState createState() => _EventsAppBarState();
}

class _EventsAppBarState extends State<EventsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 25, left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffffffff)),
                shape: BoxShape.circle,
                //color: Color(0xffffffff),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          const Text(
            'Mapa',
            style: TextStyle(
              fontSize: 28,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => {},
                child: Container(
                  margin: const EdgeInsets.only(top: 30, right: 10),
                  transform: Matrix4.rotationZ(100),
                  child: Stack(
                    children: const [
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
