import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/util/dates.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'event_city_admin_cubit.dart';
import 'event_city_admin_state.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class EventCityAdminScreen extends StatelessWidget {
  const EventCityAdminScreen({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCityAdminCubit>();
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
          'Administrador',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          CalendarDetails(eventCity: eventCity),
          const Divider(),
          ListUserCheckIn(usersCheckIn: eventCity.usersCheckIn)
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 45,
          ),
          child: BlocConsumer<EventCityAdminCubit, EventCityAdminState>(
            listenWhen: (oldState, newState) =>
                oldState.status != newState.status,
            listener: (context, state) {
              if (state.status == EventCityAdminStatus.failed) {
                presentBottomSheet(
                  context: context,
                  builder: (_) => const ConfirmationErrorModal(),
                );
              }
              if (state.status == EventCityAdminStatus.succeeds) {
                presentBottomSheet(
                  context: context,
                  builder: (_) => ConfirmationSucceeds(
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
                text: 'Compareceu',
                type: ButtonActionType.primary,
                onPressed: state.listSelected.isNotEmpty
                    ? () => cubit.action(eventCity)
                    : null,
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

class ListUserCheckIn extends StatelessWidget {
  const ListUserCheckIn({
    Key? key,
    required this.usersCheckIn,
  }) : super(key: key);
  final List<User> usersCheckIn;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCityAdminCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: SingleChildScrollView(
        child: BlocBuilder<EventCityAdminCubit, EventCityAdminState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Solicitações'),
                    Text('Compareceram'),
                  ],
                ).withPaddingSymmetric(horizontal: 16.0),
                const SizedBox(height: 16),
                ...usersCheckIn
                    .map(
                      (user) => CheckboxListTile(
                        key: Key('user-check-in-${user.id}'),
                        secondary: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: state.listSelected.contains(user.id),
                        onChanged: (newValue) {
                          if (newValue == true) {
                            cubit.setUserInConfirmation(user.id);
                          } else {
                            cubit.removeUserInConfirmation(user.id);
                          }
                        },
                      ),
                    )
                    .toList()
              ],
            );
          },
        ),
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

class ConfirmationErrorModal extends StatelessWidget {
  const ConfirmationErrorModal({
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
            'Falha na confirmação',
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
            '''Aconteceu algum problema ao fazer a confirmação de presença. Por favor tente novamente mais tarde.''',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

class ConfirmationSucceeds extends StatelessWidget {
  const ConfirmationSucceeds({
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
            'Confirmação de presença realizada!',
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
            '''Muito obrigado por realizar a confirmação de presença dos seus alunos, e boa aula''',
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
