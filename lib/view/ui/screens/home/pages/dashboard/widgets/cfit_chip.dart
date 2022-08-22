import 'package:cfit/view/ui/screens/home/home_state.dart';
import 'package:flutter/material.dart';

class ChipCFit extends StatelessWidget {
  const ChipCFit({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final void Function(HomeStateEventsFilter filter) onPressed;
  final HomeStateEventsFilter value;

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
      onPressed: () => onPressed(value),
    );
  }
}
