import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

void presentBottomSheet({
  required BuildContext context,
  required Modal modal,
}) {
  Widget? buildBottomBar() {
    if (modal.primaryAction != null && modal.secondaryAction != null) {
      return SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [modal.primaryAction!, modal.secondaryAction!],
        ),
      ).withPaddingOnly(bottom: 40);
    }
    if (modal.primaryAction != null) {
      return SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: modal.primaryAction,
      ).withPaddingOnly(bottom: 40);
    }
    return null;
  }

  showModalBottomSheet(
    context: context,
    isDismissible: true,
    constraints: BoxConstraints.loose(Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height * modal.fraction,
    )),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
          extendBody: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              modal.title.withPaddingSymmetric(horizontal: 16),
              const SizedBox(height: 24),
              modal.subtitle?.withPaddingSymmetric(horizontal: 16) ??
                  const SizedBox.shrink(),
            ],
          ),
          bottomNavigationBar: buildBottomBar(),
        ),
      );
    },
    elevation: 5,
  );
}
