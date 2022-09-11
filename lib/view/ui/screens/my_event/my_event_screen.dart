import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_event_cubit.dart';
import 'my_event_state.dart';
import 'widgets/widgets.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  
  final User user;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyEventCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
          onPressed: cubit.onBack,
        ),
        title: const Text(
          'Meu Evento',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<MyEventCubit, MyEventState>(
        builder: (context, state) {
          if (state.loadingRequest) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.75,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.75,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.5,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
                LoadingBox(
                  height: 40,
                  customWidth: MediaQuery.of(context).size.width * 0.5,
                ).withPaddingOnly(
                  bottom: 8,
                  top: 8,
                ),
              ],
            ).withPaddingSymmetric(horizontal: 16);
          }
          return Flex(
            direction: Axis.vertical,
            children: [
              Details(eventPublic: state.event),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade300,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Solicitações",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Aceitar/Recusar",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ).withPaddingOnly(bottom: 16),
                      ...state.event.usersConfirmation
                          .map(
                            (user) => Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColorDark,
                                  child: const Icon(Icons.person),
                                ),
                              ],
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
