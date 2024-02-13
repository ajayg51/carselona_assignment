class DashboardResponse {
  int status;
  String msg;
  DashboardResponseData? responseData;

  DashboardResponse({
    required this.status,
    required this.msg,
    required this.responseData,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> map) =>
      DashboardResponse(
        status: map["status"]?.toInt() ?? 0,
        msg: map["msg"] ?? "",
        responseData: map["dashboardData"] == null
            ? null
            : DashboardResponseData.fromJson(map["dashboardData"]),
      );

  factory DashboardResponse.empty() => DashboardResponse.fromJson({});
}

class DashboardResponseData {
  CurrentData? currentData;
  ThisMonth? thisMonth;
  ThisMonth? today;
  MonthWiseProgress? monthWiseProgress;
  List<ListElement> lists;

  DashboardResponseData({
    required this.currentData,
    required this.thisMonth,
    required this.today,
    required this.monthWiseProgress,
    required this.lists,
  });

  factory DashboardResponseData.fromJson(Map<String, dynamic> map) =>
      DashboardResponseData(
        currentData: map["currentData"] == null
            ? null
            : CurrentData.fromJson(map["currentData"]),
        thisMonth: map["thisMonth"] == null
            ? null
            : ThisMonth.fromJson(map["thisMonth"]),
        today: map["today"] == null ? null : ThisMonth.fromJson(map["today"]),
        monthWiseProgress: map["monthWiseProgress"] == null
            ? null
            : MonthWiseProgress.fromJson(map["monthWiseProgress"]),
        lists: map["lists"] == null
            ? []
            : List<ListElement>.from(
                map["lists"].map((x) => ListElement.fromJson(x))),
      );
}

class CurrentData {
  ThisMonth? active;
  ThisMonth? inactive;

  CurrentData({
    required this.active,
    required this.inactive,
  });

  factory CurrentData.fromJson(Map<String, dynamic> map) => CurrentData(
        active:
            map["active"] == null ? null : ThisMonth.fromJson(map["active"]),
        inactive: map["inactive"] == null
            ? null
            : ThisMonth.fromJson(map["inactive"]),
      );
}

class ThisMonth {
  String label;
  int totalCount;
  Config? config;
  List<GraphDatum> graphData;

  ThisMonth({
    required this.label,
    required this.totalCount,
    required this.graphData,
    this.config,
  });

  factory ThisMonth.fromJson(Map<String, dynamic> map) => ThisMonth(
        label: map["label"] ?? "",
        totalCount: map["totalCount"]?.toInt() ?? 0,
        graphData: map["graphData"] == null
            ? []
            : List<GraphDatum>.from(
                map["graphData"].map((x) => GraphDatum.fromJson(x))),
        config: map["config"] == null ? null : Config.fromJson(map["config"]),
      );
}

class Config {
  List<int> subscriptionIds;
  int length;
  String orders;
  String columns;

  Config({
    required this.subscriptionIds,
    required this.length,
    required this.orders,
    required this.columns,
  });

  factory Config.fromJson(Map<String, dynamic> map) => Config(
        subscriptionIds: map["subscriptionIds"] == null
            ? []
            : List<int>.from(map["subscriptionIds"].map((x) => x)),
        length: map["length"]?.toInt() ?? 0,
        orders: map["orders"] ?? "",
        columns: map["columns"] ?? "",
      );
}

class GraphDatum {
  String name;
  int value;

  GraphDatum({
    required this.name,
    required this.value,
  });

  factory GraphDatum.fromJson(Map<String, dynamic> map) => GraphDatum(
        name: map["name"] ?? "",
        value: map["value"] ?? "",
      );
}

class ListElement {
  String label;
  int count;
  Config? config;

  ListElement({
    required this.label,
    required this.count,
    required this.config,
  });

  factory ListElement.fromJson(Map<String, dynamic> map) => ListElement(
        label: map["label"] ?? "",
        count: map["count"]?.toInt() ?? 0,
        config: map["config"] == null ? null : Config.fromJson(map["config"]),
      );
}

class MonthWiseProgress {
  String label;
  List<Datum> data;

  MonthWiseProgress({
    required this.label,
    required this.data,
  });

  factory MonthWiseProgress.fromJson(Map<String, dynamic> map) =>
      MonthWiseProgress(
        label: map["label"] ?? "",
        data: map["data"] == null
            ? []
            : List<Datum>.from(map["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  String name;
  int value;
  String color;

  Datum({
    required this.name,
    required this.value,
    required this.color,
  });

  factory Datum.fromJson(Map<String, dynamic> map) => Datum(
        name: map["name"] ?? "",
        value: map["value"] ?? "",
        color: map["color"] ?? "",
      );
}
