import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirmation_delete_error_modal.dart';

class ConfirmDeleteModal extends Modal {
  const ConfirmDeleteModal({
    Key? key,
    required this.eventPublic,
    required this.onPressed,
  }) : super(key: key);

  final EventPublic eventPublic;
  final Future<bool?> Function() onPressed;

  @override
  double get fraction => 0.5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmDeleteModalCubit(),
      child: ConfirmationDeleteScreen(
        eventPublic: eventPublic,
        onPressed: onPressed,
      ),
    );
  }
}

class ConfirmationDeleteScreen extends StatelessWidget {
  const ConfirmationDeleteScreen({
    Key? key,
    required this.eventPublic,
    required this.onPressed,
  }) : super(key: key);

  final EventPublic eventPublic;
  final Future<bool?> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConfirmDeleteModalCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deseja mesmo apagar este evento',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            Expanded(
              child: Text(
                'Você tem certeza que deseja apagar "${eventPublic.name}" ? Caso esse evento seja excluído, você não poderá retomar com ele. E as pessoas que já demostraram interesse em participar não o mais verão na sua tela inicial. ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<ConfirmDeleteModalCubit, ConfirmDeleteModalState>(
        listener: (context, state) {
          if (state.hasError) {
            Navigator.pop(context);
            presentBottomSheet(
              context: context,
              modal: const ConfirmDeleteErrorModal(),
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 80,
            child: ButtonAction(
              text: 'Apagar',
              type: ButtonActionType.primary,
              onPressed: () async {
                cubit.startRequest();

                final success = await onPressed();
                cubit.finishRequest(success == false ? true : false);
              },
              customBackgroundColor: const Color(0xFFAA121E),
              loading: state.loading,
            ),
          );
        },
      ).withPaddingOnly(bottom: 36),
    );
  }
}

class ConfirmDeleteModalState {
  final bool loading;
  final bool hasError;

  ConfirmDeleteModalState({
    required this.loading,
    required this.hasError,
  });
  factory ConfirmDeleteModalState.empty() {
    return ConfirmDeleteModalState(
      loading: false,
      hasError: false,
    );
  }

  ConfirmDeleteModalState copyWith({
    bool? loading,
    bool? hasError,
  }) {
    return ConfirmDeleteModalState(
      loading: loading ?? this.loading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfirmDeleteModalState &&
        other.loading == loading &&
        other.hasError == hasError;
  }

  @override
  int get hashCode => loading.hashCode ^ hasError.hashCode;
}

class ConfirmDeleteModalCubit extends Cubit<ConfirmDeleteModalState> {
  ConfirmDeleteModalCubit() : super(ConfirmDeleteModalState.empty());

  void startRequest() {
    emit(state.copyWith(loading: true, hasError: false));
  }

  void finishRequest(bool? hasError) {
    emit(state.copyWith(loading: false, hasError: hasError));
  }
}
