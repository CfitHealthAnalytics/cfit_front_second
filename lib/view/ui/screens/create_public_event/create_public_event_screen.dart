import 'package:cfit/domain/models/events_public.dart';
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
  final streetFormKey = GlobalKey<FormState>();
  final numberFormKey = GlobalKey<FormState>();
  final neighborhoodFormKey = GlobalKey<FormState>();
  final cityFormKey = GlobalKey<FormState>();

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
              label: 'Nome',
              hintText: 'Ex: Caminhada da Luz',
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
                      label: Text(
                        'Tipo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                    ),
                  ).withPaddingOnly(bottom: 16);
                }),
            InputText(
              formKey: descriptionFormKey,
              hintText:
                  'Ex: Caminhada organizada pelos moradores da comunidade da luz. O objetivo da caminhada é confraternizar entre os nossos membros da comunidade.',
              onChanged: cubit.onChangeDescription,
              label: 'Descrição',
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
              label: 'Número máximo de participantes',
              hintText: 'Ex: 100',
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
                    label: 'Data',
                    formKey: dateFormKey,
                    controller: dateController,
                    hintText: 'Ex: 22/10/2023',
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
                    label: 'Hora',
                    formKey: hourFormKey,
                    hintText: 'Ex: 09:00',
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
            InputText(
              formKey: streetFormKey,
              validator: (street) {
                if (street == null || street.isEmpty) {
                  return 'Preencha o nome da rua em que o evento acontecerá';
                }
                return null;
              },
              label: 'Rua',
              hintText: 'Ex: Rua das flores',
              onChanged: cubit.onChangeStreet,
              initialValue: cubit.state.address.street,
              type: InputTextType.text,
            ).withPaddingOnly(bottom: 16),
            InputText(
              label: 'Número',
              formKey: numberFormKey,
              initialValue: cubit.state.address.number,
              validator: (number) {
                if (number == null || number.isEmpty) {
                  return 'Se não tiver numero, preencha com "s/n"';
                }
                if (number.trim().contains('s') &&
                    number.trim().contains('/') &&
                    number.trim().contains('n')) {
                  return null;
                }
                if (int.tryParse(number) == null ||
                    int.tryParse(number)! <= 0) {
                  return 'Se não tiver numero, preencha com "s/n"';
                }
                return null;
              },
              hintText: 'Ex: 1160',
              onChanged: cubit.onChangeNumber,
              type: InputTextType.text,
            ).withPaddingOnly(bottom: 16),
            InputText(
              label: 'Bairro',
              formKey: neighborhoodFormKey,
              initialValue: cubit.state.address.neighborhood,
              validator: (neighborhood) {
                if (neighborhood == null || neighborhood.isEmpty) {
                  return 'Preencha o bairro onde o evento acontecerá';
                }

                return null;
              },
              hintText: 'Ex: Boa Viagem',
              onChanged: cubit.onChangeNeighborhood,
              type: InputTextType.text,
            ).withPaddingOnly(bottom: 16),
            InputText(
              label: 'Cidade',
              formKey: cityFormKey,
              initialValue: cubit.state.address.city,
              validator: (city) {
                if (city == null || city.isEmpty) {
                  return 'Preencha a cidade onde o evento acontecerá';
                }

                return null;
              },
              hintText: 'Ex: Recife',
              onChanged: cubit.onChangeCity,
              type: InputTextType.text,
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
                      hourFormKey.currentState!.validate() &&
                      streetFormKey.currentState!.validate() &&
                      numberFormKey.currentState!.validate() &&
                      neighborhoodFormKey.currentState!.validate() &&
                      cityFormKey.currentState!.validate()) {
                    if (isDateValid()) {
                      cubit.action();
                    } else {
                      cubit.setErrorMessage(
                          'Você não pode escolher uma data no passado');
                    }
                  }
                },
              );
            }),
      ).withPaddingOnly(bottom: 24),
    );
  }
}
