import 'package:cfit/view/common/modais.dart';
import 'package:flutter/material.dart';

void presentBottomSheet<T>({
  required BuildContext context,
  required Modal modal,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    elevation: 5,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * modal.fraction,
        child: modal,
      );
    },
  );
}
