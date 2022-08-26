import 'package:cfit/di/build_context.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_cubit.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_navigation.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePublicEventModal extends Modal {
  const CreatePublicEventModal({
    Key? key,
    required this.user,
    required this.onCreate,
  }) : super(key: key);
  final User user;
  final void Function(bool) onCreate;

  @override
  double get fraction => 0.8;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePublicEventCubit(
        navigation: CreatePublicEventNavigation.fromMaterialNavigation(
          Navigator.of(context),
        ),
        categoriesEventUseCase: context.categoriesEventUseCase(),
        createEventPublicUseCase: context.createEventPublicUseCase(),
        user: user,
        onCreate: onCreate,
      ),
      child: CreatePublicEventScreen(),
    );
  }
}
