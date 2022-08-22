import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'event_details_cubit.dart';
import 'event_details_state.dart';
import 'widgets/widgets.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({
    Key? key,
    required this.eventCity,
    required this.user,
  }) : super(key: key);

  final EventCity eventCity;
  final User user;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventDetailsCubit>();
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
            CalendarDetails(eventCity: eventCity),
            const Divider(),
            Details(eventCity: eventCity)
          ],
        ),
      ),
      bottomNavigationBar: eventCity.usersConfirmation.contains(user.id)
          ? Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 50,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: const Text(
                'Sua presença já foi confirmada pelo professor',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
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
                child: BlocConsumer<EventDetailsCubit, EventDetailsState>(
                  listener: (context, state) {
                    if (state.status == EventDetailsStatus.failed) {
                      presentBottomSheet(
                        context: context,
                        modal: ScheduleErrorModal(
                            isUnscheduled: cubit.alreadyScheduled,
                            context: context,
                            onPressed: () {
                              Navigator.of(context).pop();
                              cubit.action(eventCity);
                            }),
                      );
                    }
                    if (state.status == EventDetailsStatus.succeeds) {
                      presentBottomSheet(
                        context: context,
                        modal: ScheduleConfirmation(
                          onPressed: () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          },
                          isUnscheduled: cubit.alreadyScheduled,
                          context: context,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ButtonAction(
                      text: cubit.alreadyScheduled ? 'Desagendar' : 'Agendar',
                      type: ButtonActionType.primary,
                      onPressed: () => cubit.action(eventCity),
                      customBackgroundColor: Theme.of(context).primaryColor,
                      loading: state.loadingRequest,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
