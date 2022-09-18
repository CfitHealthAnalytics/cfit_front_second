import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
    );
  }
}
