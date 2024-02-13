import 'package:carselona_assignment/models/dashboard_response.dart';
import 'package:carselona_assignment/services/dashboard_service.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final isLoading = true.obs;
  DashboardResponseData? data;
  final error = "".obs;

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  void fetchData() async {
    final year = DateTime.now().year.toString();
    String month = DateTime.now().month.toString();
    String day = DateTime.now().day.toString();
    month = month.padLeft(2, "0");
    day = day.padLeft(2, "0");

    data =
        await DashboardService.getDashboardData(startDate: "$year-$month-$day");
    error.value = DashboardService.error.value;
    isLoading.value = false;
  }
}
