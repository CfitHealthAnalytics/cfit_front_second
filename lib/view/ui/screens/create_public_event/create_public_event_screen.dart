import 'package:cfit/domain/models/events_public.dart';
import 'package:cfit/theme.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/input_text.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_cubit.dart';
import 'package:cfit/view/ui/screens/create_public_event/create_public_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final dateEventMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final hourEventMask = MaskTextInputFormatter(
  mask: '##:##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class CreatePublicEventScreen extends StatelessWidget {
  CreatePublicEventScreen({
    Key? key,
    this.event,
  })  : hourController = TextEditingController(
            text: event != null ? event.startTime.getCustomHour() : ''),
        dateController = TextEditingController(
            text: event != null
                ? event.startTime.getCustomDate(withYear: true)
                : ''),
        super(key: key);

  final EventPublic? event;
  final nameFormKey = GlobalKey<FormState>();
  final descriptionFormKey = GlobalKey<FormState>();
  final numberMaxFormKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();
  final TextEditingController dateController;
  final hourFormKey = GlobalKey<FormState>();
  final TextEditingController hourController;
  final localizationFormKey = GlobalKey<FormState>();

  bool isDateValid() {
    final dateInputted = dateController.value;
    final hourInputted = hourController.value;

    final dateArray = dateInputted.text.split('/');
    final hourArray = hourInputted.text.split(':');
    final eventDate = DateTime(
      int.parse(dateArray[2]),
      int.parse(dateArray[1]),
      int.parse(dateArray[0]),
      int.parse(hourArray[0]),
      int.parse(hourArray[1]),
    );

    return eventDate.isAfter(DateTime.now().toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePublicEventCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cubit.isEdit ? 'Editar Evento' : 'Criar Evento',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputText(
              formKey: nameFormKey,
              hintText: 'Nome do Evento',
              onChanged: cubit.onChangeName,
              type: InputTextType.text,
              initialValue: cubit.state.name,
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'O nome do evento é necessário';
                }
                if (name.length <= 4) {
                  return 'Nomes muito pequenos podem não ser tão atrativo';
                }
                return null;
              },
            ).withPaddingOnly(bottom: 16),
            FutureBuilder<List<String>>(
                future: cubit.getCategoriesEvent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const LoadingBox(
                      height: 60,
                      customWidth: double.infinity,
                    ).withPaddingOnly(bottom: 16);
                  }
                  final categories = snapshot.data!;
                  if (!categories.contains(cubit.state.type)) {
                    cubit.onChangeType(categories.first);
                  }
                  return DropdownButtonFormField<String>(
                    items: categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.upperOnlyFirstLetter(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: cubit.onChangeType,
                    elevation: 0,
                    value: categories.contains(cubit.state.type)
                        ? categories.firstWhere(
                            (category) => category == cubit.state.type)
                        : categories.first,
                    decoration: const InputDecoration(
                      hintText: "Tipo de evento",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                    ),
                  ).withPaddingOnly(bottom: 16);
                }),
            InputText(
              formKey: descriptionFormKey,
              hintText: 'Descreva o evento',
              onChanged: cubit.onChangeDescription,
              type: InputTextType.textArea,
              initialValue: cubit.state.description,
              validator: (description) {
                if (description == null || description.isEmpty) {
                  return 'Uma descrição do evento é necessário';
                }
                if (description.length <= 10) {
                  return 'Descreva um pouco melhor seu evento';
                }
                return null;
              },
            ).withPaddingOnly(bottom: 16),
            InputText(
              formKey: numberMaxFormKey,
              hintText: 'Numero máximo de participantes',
              onChanged: cubit.onChangeCountMax,
              type: InputTextType.number,
              initialValue: cubit.state.countMax.toString(),
              validator: (countMax) {
                try {
                  if (countMax == null ||
                      double.tryParse(countMax) == null ||
                      double.parse(countMax) < 1.0) {
                    return 'O evento precisa ter no mínimo 1 participante';
                  }
                } catch (e) {
                  return 'O evento precisa ter no mínimo 1 participante';
                }
                return null;
              },
            ).withPaddingOnly(bottom: 16),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: InputText(
                    formKey: dateFormKey,
                    controller: dateController,
                    hintText: 'Data',
                    onChanged: cubit.onChangeDate,
                    type: InputTextType.date,
                    inputFormatter: [dateEventMask],
                    validator: (date) {
                      if (date == null || date.length != 10) {
                        return 'Você precisa fornecer uma data válida para o evento';
                      }
                      final dateArray = date.split('/');
                      if (dateArray.length != 3) {
                        return 'Insira uma data válida';
                      }
                      if (int.parse(dateArray[2]) > 2050 ||
                          int.parse(dateArray[2]) < 2022) {
                        return 'Ano do evento invalido';
                      }
                      if (int.parse(dateArray[1]) > 12 ||
                          int.parse(dateArray[1]) < 1) {
                        return 'Mês do evento invalido';
                      }
                      if (int.parse(dateArray[0]) > 31 ||
                          int.parse(dateArray[2]) < 1) {
                        return 'Dia do evento invalido';
                      }
                      return null;
                    },
                  ).withPaddingOnly(bottom: 16),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: InputText(
                    formKey: hourFormKey,
                    hintText: 'Horário',
                    controller: hourController,
                    onChanged: cubit.onChangeHour,
                    type: InputTextType.date,
                    inputFormatter: [hourEventMask],
                    validator: (hour) {
                      if (hour == null || hour.length != 5) {
                        return 'Você precisa fornecer um horário válido para o evento';
                      }
                      final hourArray = hour.split(':');
                      if (hourArray.length != 2) {
                        return 'Insira um horário válida';
                      }
                      if (int.parse(hourArray[1]) > 59 ||
                          int.parse(hourArray[1]) < 0) {
                        return 'horário do evento invalido';
                      }
                      if (int.parse(hourArray[0]) > 24 ||
                          int.parse(hourArray[0]) < 0) {
                        return 'horário do evento invalido';
                      }
                      return null;
                    },
                  ).withPaddingOnly(bottom: 16),
                )
              ],
            ).withPaddingOnly(bottom: 16),
            BlocBuilder<CreatePublicEventCubit, CreatePublicEventState>(
              builder: ((context, state) {
                if (state.errorMessage != null) {
                  return Text(
                    state.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ).withPaddingOnly(bottom: 16);
                }
                return const SizedBox();
              }),
            ),
            BlocBuilder<CreatePublicEventCubit, CreatePublicEventState>(
                builder: (context, state) {
              if (cubit.localization == null) {
                return ButtonAction(
                  text: 'Selecionar local',
                  type: ButtonActionType.text,
                  onPressed: cubit.selectLocation,
                  textStyle: const TextStyle(
                    color: primaryColorDark,
                    decoration: TextDecoration.underline,
                  ),
                );
              }
              return Stack(
                alignment: Alignment.centerRight,
                children: [
                  Form(
                    key: localizationFormKey,
                    child: TextFormField(
                      initialValue: cubit.localization,
                      enabled: state.editLocalization,
                      onChanged: cubit.onChangeAddress,
                      style: TextStyle(
                        color: state.editLocalization
                            ? Colors.grey.shade600
                            : Colors.grey,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        if (state.editLocalization == false) {
                          cubit.allowEditLocalization();
                        } else {
                          cubit.forbidEditLocalization();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          !state.editLocalization ? Icons.edit : Icons.edit_off,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ],
        ).withPaddingSymmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BlocBuilder<CreatePublicEventCubit, CreatePublicEventState>(
            buildWhen: (previous, current) =>
                previous.loadingRequest != current.loadingRequest,
            builder: (context, state) {
              return ButtonAction(
                text: cubit.isEdit ? 'Editar Evento' : 'Criar Evento',
                type: ButtonActionType.primary,
                loading: state.loadingRequest,
                onPressed: () {
                  if (nameFormKey.currentState!.validate() &&
                      descriptionFormKey.currentState!.validate() &&
                      numberMaxFormKey.currentState!.validate() &&
                      dateFormKey.currentState!.validate() &&
                      hourFormKey.currentState!.validate()) {
                    if (localizationFormKey.currentState == null ||
                        !localizationFormKey.currentState!.validate()) {
                      cubit.setErrorMessage(
                        'Você precisa selecionar a localização',
                      );
                    } else {
                      if (isDateValid()) {
                        cubit.action();
                      } else {
                        cubit.setErrorMessage(
                            'Você não pode escolher uma data no passado');
                      }
                    }
                  }
                },
              );
            }),
      ).withPaddingOnly(bottom: 24),
    );
  }
}
