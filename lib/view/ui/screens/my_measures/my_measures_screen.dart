import 'package:cfit/domain/models/bio_info.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/loading_box.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'my_measures_cubit.dart';
import 'my_mesures_state.dart';

final dateBirthMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class MyMeasureScreen extends StatelessWidget {
  const MyMeasureScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyMeasureCubit>();
    return FutureBuilder<void>(
        future: cubit.getDatas(),
        builder: (context, snapshot) {
          return BlocBuilder<MyMeasureCubit, MyMeasureState>(
            builder: (context, state) {
              if (state.loadingRequest) {
                final width = MediaQuery.of(context).size.width;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Column(
                      children: [
                        LoadingBox(
                          height: 22,
                          customWidth: width * 0.5,
                        ),
                        const SizedBox(height: 8),
                        const LoadingBox(height: 22),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoadingBox(
                        height: 200,
                        customWidth: double.infinity,
                      ).withPaddingOnly(top: 40),
                      const SizedBox(height: 60),
                      const LoadingBox(
                        height: 60,
                        customWidth: double.infinity,
                      ),
                      const SizedBox(height: 20),
                      const LoadingBox(
                        height: 60,
                        customWidth: double.infinity,
                      ),
                      const SizedBox(height: 20),
                      const LoadingBox(
                        height: 60,
                        customWidth: double.infinity,
                      ),
                    ],
                  ).withPaddingSymmetric(horizontal: 16),
                );
              }
              if (state.hasError) {
                return ErrorScreen(
                  onBack: cubit.onBack,
                  onRetry: cubit.getDatas,
                );
              }
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
                  title: Column(
                    children: const [
                      Text(
                        'Minhas Avaliações',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      LinearChat(data: state.chartData!),
                      const SizedBox(height: 40),
                      BioInfoDetail(
                        bioInfo: state.bioInfo!,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.onBack,
    required this.onRetry,
  }) : super(key: key);

  final VoidCallback onBack;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: onBack,
        ),
        title: Column(
          children: const [
            Text(
              'Minhas Avaliações',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Não conseguimos buscar seus dados.'),
            ButtonAction(
              type: ButtonActionType.text,
              text: 'Tentar novamente',
              onPressed: onRetry,
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BioInfoDetail extends StatelessWidget {
  const BioInfoDetail({
    Key? key,
    required this.bioInfo,
  }) : super(key: key);

  final BioInfo bioInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.checklist_sharp),
            const SizedBox(width: 8),
            const Text(
              'Data da avaliação: ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              bioInfo.date.formatDateHour(withAt: true),
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ).withPaddingOnly(bottom: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BioInfoContainer(
              label: 'Peso',
              value: '${bioInfo.weight.toStringAsFixed(1)} KG',
            ),
            BioInfoContainer(
              label: 'Gordura Corporal',
              value: '${bioInfo.igp}%',
            ),
          ],
        ).withPaddingOnly(bottom: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BioInfoContainer(
              label: 'Altura',
              value: '${bioInfo.height.toStringAsFixed(0)} Cm',
            ),
            BioInfoContainer(
              label: 'IMC',
              value: '${bioInfo.imc} Kg/m²',
            ),
          ],
        ).withPaddingOnly(bottom: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BioInfoContainer(
              label: 'Pulso',
              value: '${bioInfo.pulse.toStringAsFixed(0)} ppm',
            ),
          ],
        ).withPaddingOnly(bottom: 16),
      ],
    );
  }
}

class BioInfoContainer extends StatelessWidget {
  const BioInfoContainer({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class LinearChat extends StatefulWidget {
  const LinearChat({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map<DateTime, double> data;
  @override
  _LinearChatState createState() => _LinearChatState();
}

class _LinearChatState extends State<LinearChat> {
  List<Color> gradientColors = [
    const Color(0xff161C19),
    const Color(0xff274631),
    const Color(0xff4D9760),
    const Color(0xff4D9760),
    const Color(0xff274631),
    const Color(0xff161C19),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final isEnough = widget.data.entries.length > 1;
    return isEnough
        ? Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: LineChart(mainData()),
              ),
            ],
          )
        : Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade100,
            child: const Center(
                child:
                    Text('Sem dados o suficiente para a criação do grafico')),
          );
  }

  LineChartData mainData() {
    const double resevedSizeButtom = 12.0;

    final List<FlSpot> spots = [];

    final values = widget.data.values.toList();

    values.asMap().entries.forEach((entry) {
      spots.add(FlSpot(entry.key.toDouble(), entry.value));
    });

    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
