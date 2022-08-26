import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cfit_chip.dart';

class FiltersDashboard extends StatelessWidget {
  const FiltersDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          const Text(
            'Filtros: ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ).withPaddingOnly(
            left: 16.0,
            right: 8.0,
          ),
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ChipCFit(
                    label: 'Todos',
                    onPressed: cubit.setFilterDashboard,
                    isSelected: state.filter == HomeStateEventsFilter.all,
                    value: HomeStateEventsFilter.all,
                  ).withPaddingSymmetric(horizontal: 4.0),
                  ChipCFit(
                    label: 'Criados por mim',
                    onPressed: cubit.setFilterDashboard,
                    isSelected: state.filter == HomeStateEventsFilter.my,
                    value: HomeStateEventsFilter.my,
                  ).withPaddingSymmetric(horizontal: 4.0),
                  ChipCFit(
                    label: 'Academia Recife',
                    onPressed: cubit.setFilterDashboard,
                    isSelected: state.filter == HomeStateEventsFilter.gymCity,
                    value: HomeStateEventsFilter.gymCity,
                  ).withPaddingSymmetric(horizontal: 4.0),
                  ChipCFit(
                    label: 'Público',
                    onPressed: cubit.setFilterDashboard,
                    isSelected: state.filter == HomeStateEventsFilter.public,
                    value: HomeStateEventsFilter.public,
                  ).withPaddingSymmetric(horizontal: 4.0),
                ],
              ),
            );
          }),
        ],
      ),
    ).withPaddingSymmetric(vertical: 8);
  }
}
