import 'dart:ui';

import 'package:carselona_assignment/models/dashboard_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

enum GraphType {
  active,
  inActive,
  thisMonth,
  today,
}

extension GraphTypeExt on GraphType {
  List<FlSpot> getGraphPoints(DashboardResponseData data) {
    final list = <GraphDatum>[];
    switch (this) {
      case GraphType.active:
        list.assignAll(data.currentData?.active?.graphData ?? []);
        break;
      case GraphType.inActive:
        list.assignAll(data.currentData?.inactive?.graphData ?? []);
        break;
      case GraphType.thisMonth:
        list.assignAll(data.thisMonth?.graphData ?? []);
        break;
      case GraphType.today:
        list.assignAll(data.today?.graphData ?? []);
        break;
    }

    final resultList = <FlSpot>[];
    for (int i = 0; i < list.length; i++) {
      FlSpot spot = FlSpot(
        i.toDouble(),
        list[i].value.toDouble(),
      );

      resultList.add(spot);
    }

    return resultList;
  }

  List<Color> get getGradientColorList {
    switch (this) {
      case GraphType.thisMonth:
      case GraphType.today:
      case GraphType.active:
        return const [
          Color(0xffEC66B5),
          Color(0xffDF67BC),
          Color(0xffED66B6),
          Color(0xffDD63C0),
          Color(0xffBB79D4),
        ];
      case GraphType.inActive:
        return const [
          Color(0xff3737C5),
          Color(0xff5A54DC),
          Color(0xff6361E1),
          Color(0xff7C78E6),
          Color(0xffB7B5F4)
        ];
    }
  }
}
