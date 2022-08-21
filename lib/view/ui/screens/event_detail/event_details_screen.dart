import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'event_details_cubit.dart';
import 'event_details_state.dart';

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
              ))),
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
                        builder: (_) => ScheduleErrorModal(
                          isUnscheduled: cubit.alreadyScheduled,
                        ),
                      );
                    }
                    if (state.status == EventDetailsStatus.succeeds) {
                      presentBottomSheet(
                        context: context,
                        builder: (_) => ScheduleConfirmation(
                          isUnscheduled: cubit.alreadyScheduled,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
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

class Details extends StatelessWidget {
  const Details({Key? key, required this.eventCity}) : super(key: key);
  final EventCity eventCity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/AcademiaRecife.png',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventCity.type.upperOnlyFirstLetter(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  child: Text(
                    eventCity.description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Duração',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1 hora',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDetails extends StatelessWidget {
  const CalendarDetails({
    Key? key,
    required this.eventCity,
  }) : super(key: key);
  final EventCity eventCity;

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
                  eventCity.startTime.weekday,
                  abbreviation: true,
                ),
              ),
              const SizedBox(height: 4),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  eventCity.startTime.day.toString(),
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
                eventCity.startTime.getCustomHour(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: eventCity.type.upperOnlyFirstLetter(),
                  children: [
                    const TextSpan(text: ' - '),
                    TextSpan(
                      text: eventCity.neighborhood.upperOnlyFirstLetter(),
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
                    text: eventCity.usersCheckIn.length.toString(),
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
                        text: eventCity.countMaxUsers.toString(),
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

class ScheduleErrorModal extends StatelessWidget {
  const ScheduleErrorModal({
    Key? key,
    required this.isUnscheduled,
  }) : super(key: key);
  final bool isUnscheduled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            isUnscheduled
                ? 'Falha ao tentar desagendar'
                : 'Falha no agendamento',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            isUnscheduled
                ? '''Aconteceu algum problema ao fazer o seu desagendamento. Por favor tente novamente mais tarde.'''
                : '''Aconteceu algum problema ao fazer o seu agendamento. Por favor tente novamente mais tarde.''',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

class ScheduleConfirmation extends StatelessWidget {
  const ScheduleConfirmation(
      {Key? key, required this.onPressed, required this.isUnscheduled})
      : super(key: key);
  final VoidCallback onPressed;
  final bool isUnscheduled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            isUnscheduled
                ? 'Desagendamento realizado!'
                : 'Agendamento confirmado!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            isUnscheduled
                ? ''
                : '''Não se esqueça de adicionar na sua agenda.''',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ButtonAction(
          text: 'Fechar',
          type: ButtonActionType.primary,
          onPressed: onPressed,
          customBackgroundColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
