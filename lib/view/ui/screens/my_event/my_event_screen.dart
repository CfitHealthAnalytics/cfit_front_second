import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'my_event_cubit.dart';
import 'my_event_state.dart';
import 'widgets/widgets.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyEventCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
          onPressed: cubit.onBack,
        ),
        title: const Text(
          'Meu Evento',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<MyEventCubit, MyEventState>(
        builder: (context, state) {
          if (state.loadingRequest) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.75,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.75,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.5,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.5,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
              ],
            ).withPaddingSymmetric(horizontal: 16);
          }
          return Flex(
            direction: Axis.vertical,
            children: [
              if (state.loadingPartial) const LinearProgressIndicator(),
              Details(eventPublic: state.event),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.grey.shade300,
                  child: BlocBuilder<MyEventCubit, MyEventState>(
                    builder: (context, state) {
                      return ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Solicitações",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Aceitar/Recusar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ).withPaddingOnly(bottom: 8),
                          ...state.event.usersCheckIn
                              .map(
                                (user) => Slidable(
                                  enabled: (state.event.usersConfirmation
                                          .contains(user.id) ||
                                      state.event.usersRejection
                                          .contains(user.id)),
                                  endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    extentRatio: 0.28,
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) => state
                                                .event.usersConfirmation
                                                .contains(user.id)
                                            ? cubit
                                                .confirmeParticipants(user.id)
                                            : cubit
                                                .declineParticipants(user.id),
                                        label: 'Desfazer',
                                        icon:
                                            Icons.cancel_presentation_outlined,
                                        backgroundColor:
                                            const Color(0xFFAA121E),
                                      )
                                    ],
                                  ),
                                  direction: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .primaryColorDark,
                                            child: const Icon(Icons.person),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            user.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Actions(
                                        eventPublic: state.event,
                                        user: user,
                                        acceptAction: () =>
                                            cubit.confirmeParticipants(user.id),
                                        declineAction: () =>
                                            cubit.declineParticipants(user.id),
                                      ).withPaddingOnly(right: 4),
                                    ],
                                  ).withPaddingOnly(
                                    bottom: 8,
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({
    Key? key,
    required this.eventPublic,
    required this.user,
    required this.declineAction,
    required this.acceptAction,
  }) : super(key: key);

  final EventPublic eventPublic;
  final User user;
  final Function() acceptAction;
  final Function() declineAction;

  @override
  Widget build(BuildContext context) {
    if (eventPublic.usersConfirmation.contains(user.id)) {
      return Row(
        children: [
          Text(
            'Aceito',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ],
      );
    }

    if (eventPublic.usersRejection.contains(user.id)) {
      return Row(
        children: const [
          Text(
            'Recusado',
            style: TextStyle(
              color: Color(0xFFEF4949),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Color(0xFFEF4949),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ],
      );
    }
    return Row(
      children: [
        ButtonAction(
          type: ButtonActionType.icon,
          icon: Icons.check,
          onPressed: acceptAction,
        ),
        const SizedBox(width: 4),
        ButtonAction(
          type: ButtonActionType.icon,
          icon: Icons.close,
          customBackgroundColor: const Color(0xFFEF4949),
          onPressed: declineAction,
        ),
      ],
    );
  }
}
