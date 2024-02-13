import 'package:carselona_assignment/models/dashboard_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardService {
  static final dio = Dio();
  static final error = "".obs;
  static const id = 3725;
  static const url =
      "https://api.carselonadaily.com/api/admin/getCustomerStatsBySupervisorId";

  static Future<DashboardResponseData?> getDashboardData({
    required String startDate,
  }) async {
    debugPrint(startDate);
    try {
      final response = await dio.post(
        url,
        data: {
          "startDate": startDate,
          "supervisorId": id,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("All ok");
        if (response.data != null) {
          debugPrint("data found");
          debugPrint(response.data.toString());
          final data = DashboardResponse.fromJson(response.data);
          
          return data.responseData;
        } else {
          error.value += "data is null ";
          debugPrint("data not found");
        }
      } else {
        error.value += " ${response.statusCode}";
        debugPrint("data not found");
      }
    } catch (e) {
      error.value += " $e";
      debugPrint("Error $e");
    }

    return null;
  }
}
