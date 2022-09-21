import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/bottom_warning.dart';
import 'package:cfit/view/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'event_public_detail_cubit.dart';
import 'event_public_detail_state.dart';
import 'widgets/widgets.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class EventPublicDetailsScreen extends StatelessWidget {
  const EventPublicDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventPublicDetailsCubit>();
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
          'Participar',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarDetails(eventPublic: cubit.eventPublic),
            const Divider(),
            Details(eventPublic: cubit.eventPublic)
          ],
        ),
      ),
      bottomNavigationBar: cubit.isRejected
          ? const BottomWarning(
              label: 'Você foi recusado pelo organizador do evento :/',
            )
          : cubit.isFilled
              ? const BottomWarning(label: 'Este evento já está lotado.')
              : cubit.eventPublic.usersConfirmation.contains(cubit.user.id)
                  ? const BottomWarning(
                      label: 'Sua presença já foi confirmada pelo professor',
                    )
                  : SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          bottom: 45,
                        ),
                        child: BlocConsumer<EventPublicDetailsCubit,
                            EventPublicDetailsState>(
                          listener: (context, state) {
                            if (state.status ==
                                EventPublicDetailsStatus.failed) {
                              presentBottomSheet(
                                context: context,
                                modal: ScheduleErrorModal(
                                  isUnscheduled: cubit.alreadyScheduled,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    cubit.action();
                                  },
                                ),
                              );
                            }
                            if (state.status ==
                                EventPublicDetailsStatus.succeeds) {
                              presentBottomSheet(
                                context: context,
                                modal: ScheduleConfirmation(
                                  isUnscheduled: cubit.alreadyScheduled,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ButtonAction(
                              text: cubit.alreadyScheduled
                                  ? 'Desagendar'
                                  : 'Agendar',
                              type: ButtonActionType.primary,
                              onPressed: cubit.action,
                              customBackgroundColor:
                                  Theme.of(context).primaryColor,
                              loading: state.loadingRequest,
                            );
                          },
                        ),
                      ),
                    ),
    );
  }
}
