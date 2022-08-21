import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'my_event_cubit.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

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
      body: Flex(
        direction: Axis.vertical,
        children: [
          Details(eventCity: eventCity),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade300,
              child: ListView(
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
                      ),
                    ],
                  ).withPaddingOnly(bottom: 16),
                  ...eventCity.usersConfirmation
                      .map(
                        (user) => Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              child: const Icon(Icons.person),
                            ),
                          ],
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            eventCity.type.upperOnlyFirstLetter(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ).withPaddingOnly(bottom: 16),
          Text(
            eventCity.description.upperOnlyFirstLetter(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ).withPaddingOnly(bottom: 16),
          CharacteristicEvent(
            label: 'Categoria',
            value: eventCity.type.upperOnlyFirstLetter(),
          ),
          CharacteristicEvent(
            label: 'Local',
            value:
                '''${eventCity.street.upperOnlyFirstLetter()} ${eventCity.number}, ${eventCity.neighborhood}, ${eventCity.city}''',
          ),
          CharacteristicEvent(
            label: 'Data / hora',
            value: eventCity.startTime.formatDateHour(),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountConfirmed(eventCity: eventCity),
              ChipCFit(
                label: 'Editar',
                isSelected: true,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ChipCFit extends StatelessWidget {
  const ChipCFit({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorDark,
      onPressed: onPressed,
    );
  }
}


class CountConfirmed extends StatelessWidget {
  const CountConfirmed({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
            text: eventCity.usersConfirmation.length.toString(),
            style: const TextStyle(color: Colors.black),
            children: [
              const TextSpan(text: '/'),
              TextSpan(
                text: eventCity.countMaxUsers.toString(),
              ),
            ],
          ),
        )
      ],
    ).withPaddingSymmetric(vertical: 4);
  }
}

class CharacteristicEvent extends StatelessWidget {
  const CharacteristicEvent({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          children: [
            TextSpan(
                text: value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ))
          ]),
    ).withPaddingSymmetric(vertical: 4);
  }
}

class ScheduleErrorModal extends StatelessWidget {
  const ScheduleErrorModal({
    Key? key,
  }) : super(key: key);

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Falha no agendamento',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '''Aconteceu algum problema ao fazer o seu agendamento. Por favor tente novamente mais tarde.''',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

class ScheduleConfirmation extends StatelessWidget {
  const ScheduleConfirmation({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Agendamento confirmado!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '''Não se esqueça de adicionar na sua agenda.''',
            style: TextStyle(
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
