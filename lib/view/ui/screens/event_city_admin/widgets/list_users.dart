import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event_city_admin_cubit.dart';
import '../event_city_admin_state.dart';

class ListUserCheckIn extends StatelessWidget {
  const ListUserCheckIn({
    Key? key,
    required this.usersCheckIn,
    required this.usersConfirms,
  }) : super(key: key);
  final List<User> usersCheckIn;
  final List<String> usersConfirms;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCityAdminCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
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
              ...usersCheckIn.map(
                (user) {
                  final isConfirmed = usersConfirms.contains(user.id);
                  return CheckboxListTile(
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
                    tileColor:
                        isConfirmed ? Colors.grey.shade100 : Colors.transparent,
                    value: isConfirmed
                        ? isConfirmed
                        : state.listSelected.contains(user.id),
                    onChanged: isConfirmed
                        ? null
                        : (newValue) {
                            if (newValue == true) {
                              cubit.setUserInConfirmation(user.id);
                            } else {
                              cubit.removeUserInConfirmation(user.id);
                            }
                          },
                  );
                },
              ).toList()
            ],
          );
        },
      ),
    );
  }
}
