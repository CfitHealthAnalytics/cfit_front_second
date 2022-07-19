import 'dart:ui';

import 'package:cfit/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [primary];

LineChartData sleepData() {
  return LineChartData(
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      show: false,
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
        //colors: gradientColors,
        color: primary,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          const FlSpot(0.7, 2.7),
          const FlSpot(2.7, 2.7),
          const FlSpot(3.7, 5.7),
          const FlSpot(5.7, 2.7),
          const FlSpot(7.7, 4.7),
          const FlSpot(8.7, 3.7),
          const FlSpot(11.7, 4.7),
        ],
        isCurved: true,
        //colors: [thirdColor],
        color: thirdColor,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
