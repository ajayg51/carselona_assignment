import 'package:carselona_assignment/models/dashboard_response.dart';
import 'package:carselona_assignment/utils/enums.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineGraph extends StatelessWidget {
  const LineGraph({
    super.key,
    required this.graphType,
    required this.data,
  });
  final DashboardResponseData data;
  final GraphType graphType;

  @override
  Widget build(BuildContext context) {
    debugPrint(graphType.getGraphPoints(data).toString());

    final lineBarsData = LineChartBarData(
      spots: graphType.getGraphPoints(data),
      isCurved: true,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: graphType.getGradientColorList,
        ),
      ),
      gradient: const LinearGradient(
        colors: [
          Colors.transparent,
        ],
        stops: [
          0,
        ],
      ),
    );

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(border: const Border()),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineBarsData: [lineBarsData],
          minY: 0,
        ),
      ),
    );
  }
}
