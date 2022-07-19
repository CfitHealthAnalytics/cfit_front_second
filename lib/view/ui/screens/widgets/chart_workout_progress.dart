import 'package:cfit/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [primary];

LineChartData workoutProgressData() {
  return LineChartData(
    gridData: FlGridData(getDrawingVerticalLine: (value) {
      return FlLine(
        color: Colors.transparent,
        strokeWidth: 0.1,
      );
    }, getDrawingHorizontalLine: (value) {
      return FlLine(
        color: const Color(0xff37434d),
        strokeWidth: 0.1,
      );
    }),
    titlesData: FlTitlesData(
      show: true,
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 3),
          const FlSpot(2.6, 2),
          const FlSpot(4.9, 5),
          const FlSpot(6.8, 3.1),
          const FlSpot(8, 4),
          const FlSpot(9.5, 3),
          const FlSpot(11, 4),
        ],
        isCurved: true,
        color: primary,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          const FlSpot(0, 1.5),
          const FlSpot(2.5, 1),
          const FlSpot(3, 5),
          const FlSpot(5, 2),
          const FlSpot(7, 4),
          const FlSpot(8, 3),
          const FlSpot(11, 4),
        ],
        isCurved: true,
        color: thirdColor.withOpacity(0.5),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
