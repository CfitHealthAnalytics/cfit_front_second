import 'package:cfit/domain/models/address.dart';
import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/bottom_sheet.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/modais.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_modal.dart';
import 'package:cfit/view/ui/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'widgets/widgets.dart';

class BodyPublicEvents extends StatefulWidget {
  const BodyPublicEvents({
    Key? key,
    required this.getEventsPublic,
    required this.getAddress,
    required this.user,
  }) : super(key: key);
  final User user;
  final Future<List<EventPublic>> Function() getEventsPublic;
  final Future<Address?> Function() getAddress;

  @override
  State<BodyPublicEvents> createState() => _BodyPublicEventsState();
}

class _BodyPublicEventsState extends State<BodyPublicEvents> {
  bool shown = true;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      body: VisibilityDetector(
        key: const Key('public-events-result'),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction > 0 && !shown) {
            setState(() {
              shown = true;
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Próximos Eventos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ButtonAction(
                    text: '+ Criar Evento',
                    type: ButtonActionType.chip,
                    onPressed: () => presentBottomSheet(
                      context: context,
                      modal: CreatePublicEventModal(
                        user: widget.user,
                        onCreate: (result, [String? errorDetail]) {
                          if (result) {
                            presentBottomSheet(
                              context: context,
                              modal: const CreatePublicEventSuccess(),
                            );
                          } else {
                            presentBottomSheet(
                              context: context,
                              modal: CreatePublicEventError(
                                errorDetail: errorDetail,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ).withPaddingSymmetric(horizontal: 16),
              const SizedBox(height: 16),
              ResultsEvents(
                getEventsPublic: widget.getEventsPublic,
                onTap: (EventPublic eventPublic) {
                  setState(() {
                    shown = false;
                  });
                  if (eventPublic.userCreator.id == widget.user.id) {
                    cubit.navigation.toEventPublicAdmin(
                      eventPublic,
                      widget.user,
                    );
                  } else {
                    cubit.navigation.toEventPublicDetail(
                      eventPublic,
                      cubit.user!,
                      alreadyConfirmed: eventPublic.usersCheckIn
                          .where(
                              (userCheckIn) => userCheckIn.id == cubit.user!.id)
                          .isNotEmpty,
                    );
                  }
                },
              )
            ],
          ).withPaddingSymmetric(
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class ResultsEvents extends StatelessWidget {
  const ResultsEvents({
    Key? key,
    required this.getEventsPublic,
    required this.onTap,
  }) : super(key: key);
  final Future<List<EventPublic>> Function() getEventsPublic;
  final ValueSetter<EventPublic> onTap;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventPublic>>(
      future: getEventsPublic(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data?.isEmpty == true) {
          return const Center(
            child: Text('Não temos nenhum evento no momento'),
          );
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.45),
              const Text('Não temos nenhum evento no momento'),
            ],
          );
        }
        final recentEventsPublic = snapshot.data!.sortMostRecent();
        final categorizedEvents = snapshot.data!.dividerByCategory();
        return Column(
          children: [
            CarrosselEvents(
              eventsPublic: recentEventsPublic,
              onTap: onTap,
            ),
            CategorizedEvents(
              categorizedEvents: categorizedEvents,
              onTap: onTap,
            )
          ],
        );
      },
    );
  }
}

extension on List<EventPublic> {
  List<EventPublic> sortMostRecent({int take = 5}) {
    final list = this;
    list.sort((prev, next) {
      if (prev.startTime.isAfter(next.startTime)) {
        return 1;
      }
      if (prev.startTime.isBefore(next.startTime)) {
        return -1;
      }
      return 0;
    });
    return list.take(take).toList();
  }

  Map<String, List<EventPublic>> dividerByCategory() {
    final list = this;
    return list.fold<Map<String, List<EventPublic>>>(
        {},
        (previousValue, element) => {
              ...previousValue,
              element.type.toLowerCase(): [
                ...?previousValue[element.type.toLowerCase()],
                element
              ]
            });
  }
}

class CreatePublicEventSuccess extends Modal {
  const CreatePublicEventSuccess({Key? key}) : super(key: key);

  @override
  double get fraction => 0.35;

  @override
  Widget build(BuildContext context) {
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
              'Evento criado com sucesso',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            const Expanded(
              child: Text(
                'Obrigado por criar esse evento, não esqueça de convidar seus amigos para torno ainda melhor',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.only(bottom: 36),
        child: ButtonAction(
          text: 'Fechar',
          type: ButtonActionType.primary,
          customBackgroundColor: Theme.of(context).primaryColor,
          onPressed: Navigator.of(context).pop,
        ),
      ),
    );
  }
}

class CreatePublicEventError extends Modal {
  const CreatePublicEventError({Key? key, this.errorDetail}) : super(key: key);
  final String? errorDetail;
  @override
  double get fraction => 0.35;

  @override
  Widget build(BuildContext context) {
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
              'Falha ao criar o evento',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).withPaddingOnly(bottom: 16),
            Expanded(
              child: Text(
                errorDetail ??
                    'Não conseguimos criar o seu evento, por favor volte a tentar mais tarde',
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
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.only(bottom: 36),
        child: ButtonAction(
          text: 'Fechar',
          type: ButtonActionType.primary,
          customBackgroundColor: Theme.of(context).primaryColor,
          onPressed: Navigator.of(context).pop,
        ),
      ),
    );
  }
}
