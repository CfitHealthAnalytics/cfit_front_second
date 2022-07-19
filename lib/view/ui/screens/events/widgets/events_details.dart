import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';
import 'package:flutter/material.dart';
import 'package:cfit/view/base/icon_text.dart';
import 'package:get/get.dart';

class EventDetail extends StatefulWidget {
  const EventDetail(this.job, this.eventController, this.typeEvento, {Key? key})
      : super(key: key);
  final EventsModel job;
  final EventsController eventController;
  final int typeEvento;

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  // bool selected = false;
  @override
  Widget build(BuildContext context) {
    String idUser = Get.find<UserController>().idLocal;

    List<String> array1 = [];
    List<String> busca = [idUser];

    bool exists = false;

    if (widget.job.users_checkin != null) {
      for (var v in widget.job.users_checkin!) {
        if (v == idUser) {
          exists = true;
        }
      }
    }

    void showDescription() async {
      Navigator.pop(context);
    }

    return Container(
      padding: const EdgeInsets.all(25),
      height: 550,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 60,
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /*
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Image.asset(widget.job.logoUrl ?? ''),
                        ),
                        */
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.job.tipo ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              //widget.job.isMark = !widget.job.isMark;
                              // if(selected = true)
                              //   selected=false;
                            });
                          },
                          child: Container(
                            child: Icon(
                              /*
                                exists == false
                                    ? Icons.bookmark_outline_sharp
                                    : Icons.bookmark,
                                color: exists == false
                                    ? Colors.grey
                                    : Theme.of(context).primaryColor,
                          */
                              exists == false
                                  ? Icons.bookmark_outline_sharp
                                  : Icons.bookmark,
                              color: exists == false
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const Icon(Icons.more_horiz_outlined),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.job.nome ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(
                      icon: Icons.location_on_outlined,
                      text: (widget.job.rua ?? '') +
                          ' ' +
                          (widget.job.numero ?? '') +
                          ' ' +
                          (widget.job.bairro ?? '') +
                          ' ' +
                          (widget.job.cidade ?? ''),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                      ),
                      Flexible(
                        child: Text(
                          widget.job.descricao ?? '',
                          style: const TextStyle(wordSpacing: 2.5, height: 1.5),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: exists == false
                            ? Theme.of(context).primaryColor
                            : Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      //Navigator.pop(context);
                      String idEvent = widget.job.id ?? '';
                      if (idEvent.isEmpty) {
                      } else {
                        if (widget.typeEvento == 0) {
                          if (exists == false) {
                            widget.eventController
                                .checkinPublicCityEvent(widget.job.id ?? '');
                            exists = true;
                          } else {
                            widget.eventController
                                .checkoutPublicCityEvent(widget.job.id ?? '');
                          }

                          Future.delayed(const Duration(seconds: 3)).then((_) {
                            showDescription();
                          });
                        } else if (widget.typeEvento == 1) {
                          if (exists == false) {
                            widget.eventController
                                .checkinCityEvent(widget.job.id ?? '');

                            exists = true;
                          } else {
                            widget.eventController
                                .checkoutCityEvent(widget.job.id ?? '');
                          }

                          Future.delayed(const Duration(seconds: 2)).then((_) {
                            showDescription();
                          });
                        } else {
                          SnackbarUtil.showWarning(
                              message:
                                  'Tivemos um problema ao identificar sua solicitação.');
                        }
                      }
                    },
                    child: exists == false
                        ? const Text('Participar')
                        : const Text('Cancelar Participação'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
