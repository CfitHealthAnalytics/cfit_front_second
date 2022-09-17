import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'body.dart';

class AppBarPublicEvents extends StatelessWidget {
  const AppBarPublicEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return AppBar(
      title: const Text(
        'Todos eventos',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () async {
            final response = await cubit.toCreateEvent();
            if (response?.createdEvent == true) {
              presentBottomSheet(
                context: context,
                modal: const CreatePublicEventSuccess(),
              );
            } else if (response?.createdEvent == false) {
              presentBottomSheet(
                context: context,
                modal: CreatePublicEventError(
                  errorDetail: response?.reason,
                ),
              );
            }
          },
          icon: const Icon(
            Icons.location_on,
          ),
        ).withPaddingOnly(right: 8)
      ],
    );
  }
}
