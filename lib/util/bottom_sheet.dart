import 'package:flutter/material.dart';

void presentBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    constraints: BoxConstraints.loose(
      Size(
        double.infinity,
        MediaQuery.of(context).size.height * 0.35,
      ),
    ),
    builder: builder,
    elevation: 5,
  );
}
