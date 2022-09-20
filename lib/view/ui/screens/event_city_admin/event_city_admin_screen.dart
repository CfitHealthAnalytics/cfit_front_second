import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'event_city_admin_cubit.dart';
import 'event_city_admin_state.dart';
import 'widgets/widgets.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarDetails(eventCity: eventCity),
            const Divider(),
            ListUserCheckIn(
              usersCheckIn: eventCity.usersCheckIn,
              usersConfirms: eventCity.usersConfirmation,
            )
          ],
        ),
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
                  modal: const ConfirmationErrorModal(),
                );
              }
              if (state.status == EventCityAdminStatus.succeeds) {
                presentBottomSheet(
                  context: context,
                  modal: ConfirmationSucceeds(
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
