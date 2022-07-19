import 'package:cfit/presentation/shared/loading/base.widget.dart';
import 'package:cfit/view/base/animation/fadeanimation.dart';
import 'package:cfit/view/base/components/custom_button.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EventsAdd extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Container(
        padding: const EdgeInsets.all(25),
        height: 550,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: GetBuilder<EventsController>(builder: (eventController) {
            //eventController.getEventsList(reload: false);

            void _selectTime() async {
              final TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: eventController.getTime,
              );
              eventController.setTime(newTime!);
            }

            print(eventController.latitude);
            print(eventController.longitude);

            List<String> modalidades = [
              'Tipo do evento',
            ];
            if (controller.modalidades.isNotEmpty) {
              for (var v in controller.modalidades) {
                modalidades.add(v.nome);
              }
            }

            return Column(
              children: [
                Container(
                  height: 5,
                  width: 60,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Cadastro de Eventos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            focusNode: controller.nnomeFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              //controller.cidadeFocus.requestFocus();
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              errorText: controller.nnomeError.value,
                              hintText: 'Nome do evento',
                              label: const Text('Nome do evento'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                            onChanged: controller.nnome,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            focusNode: controller.ncidadeFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              //controller.cidadeFocus.requestFocus();
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              errorText: controller.ncidadeError.value,
                              hintText: 'Cidade',
                              label: const Text('Cidade'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                            onChanged: controller.ncidade,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            onChanged: controller.nbairro,
                            focusNode: controller.nbairroFocus,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Bairro',
                              label: const Text('Bairro'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            onChanged: controller.nrua,
                            focusNode: controller.nruaFocus,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Rua',
                              label: const Text('Rua'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    TextField(
                      controller: eventController.dateController,
                      readOnly: true,
                      decoration:
                          const InputDecoration(labelText: 'Data do Evento'),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1930),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          //eventController.dataP = DateFormat('dd/MM/yyyy').format(selectedDate);
                          eventController.setData(selectedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: eventController.controllerhora,
                      readOnly: true,
                      //onTap: _selectTime,
                      onTap: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: eventController.getTime,
                        );
                        if (newTime != null) {
                          eventController.setTime(newTime);
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: 'Hora do Evento'),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            onChanged: controller.nnumero,
                            focusNode: controller.nnumeroFocus,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Numero',
                              label: const Text('Numero'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            onChanged: controller.ntipoevento,
                            focusNode: controller.ntipoeventoFocus,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Tipo do evento',
                              label: const Text('Tipo do evento'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                    */
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: controller.selectModalidadeAdd,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black54),
                      underline: Container(
                        height: 2,
                        color: Colors.black54,
                      ),
                      onChanged: (String? newValue) {
                        //setState(() {
                        //dropdownValue = newValue!;
                        controller.setSelectModalidadeAdd(newValue!);
                        //});
                      },
                      items: modalidades
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.toUpperCase()),
                        );
                      }).toList(),
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            onChanged: controller.nqtdPessoas,
                            focusNode: controller.nqtdPessoasFocus,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            onFieldSubmitted: (_) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Qtd Máx. de pessoas',
                              label: const Text('Qtd Máx. de pessoas'),
                              hintStyle: Get.textTheme.headline6
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      onChanged: controller.ndescricao,
                      focusNode: controller.ndescricaoFocus,
                      textAlign: TextAlign.left,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => {
                        controller.doCadatro(),
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Descrição',
                        label: const Text('Descrição'),
                        hintStyle: Get.textTheme.headline6
                            ?.copyWith(color: Colors.black54),
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    /// LOG IN BUTTON
                    FadeAnimation(
                      delay: 1.5,
                      child: CustomButton(
                          tap: () {
                            //signIn();
                            //_login(authController);
                            controller.doCadatro();
                          },
                          text: 'Enviar'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
