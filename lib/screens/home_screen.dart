import 'package:carselona_assignment/models/dashboard_response.dart';
import 'package:carselona_assignment/screens/home_screen_controller.dart';
import 'package:carselona_assignment/screens/line_graph.dart';
import 'package:carselona_assignment/utils/assets.dart';
import 'package:carselona_assignment/utils/common_appbar.dart';
import 'package:carselona_assignment/utils/common_scaffold.dart';
import 'package:carselona_assignment/utils/enums.dart';
import 'package:carselona_assignment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        children: [
          const CommonAppbar(),
          12.verticalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  final isLoading = controller.isLoading.value;
                  final data = controller.data;
                  final error = controller.error.value;
                  if (isLoading) {
                    return buildCommonContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                          24.horizontalSpace,
                          Text(
                            "Fetching data...",
                            style: Get.textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ).padAll(value: 24),
                    ).padSymmetric(horizontalPad: 12);
                  } else if (data == null) {
                    return buildCommonContainer(
                      child: const Text("Data not found").padAll(value: 12),
                    ).padSymmetric(horizontalPad: 12);
                  }
                  return Expanded(child: buildDashboard(data));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDashboard(DashboardResponseData data) {
    return Column(
      children: [
        buildDashboardTextAndDate.padSymmetric(
          horizontalPad: 12,
          verticalPad: 12,
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              24.verticalSpace.toSliverBox,
              buildActvAndProgressByMonthCard(data)
                  .padSymmetric(horizontalPad: 12)
                  .toSliverBox,
              12.verticalSpace.toSliverBox,
              buildListItem(data),
            ],
          ),
        ),
      ],
    );
  }

  Widget get buildDashboardTextAndDate {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Dashboard",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.white,
              size: 30,
            ),
            6.horizontalSpace,
            Text(
              DateFormat("d MMM yy").format(DateTime.now()),
              style: Get.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildActvAndProgressByMonthCard(DashboardResponseData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          children: [
            buildActvInactvCard(data),
            6.verticalSpace,
            buildThisMonthOrTodayCard(
              data: data,
              graphType: GraphType.thisMonth,
              label: "This month",
              count: data.thisMonth?.totalCount.toString() ?? "",
            ),
            6.verticalSpace,
            buildThisMonthOrTodayCard(
              data: data,
              graphType: GraphType.today,
              label: "Today",
              count: data.today?.totalCount.toString() ?? "",
            ),
          ],
        )),
        12.horizontalSpace,
        Expanded(child: buildProgressByMonthCard(data)),
      ],
    );
  }

  Widget buildActvInactvCard(DashboardResponseData data) {
    final activeData = data.currentData?.active;
    final inActiveData = data.currentData?.inactive;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: buildActvInactvCardLabelCount(
                    label: activeData?.label ?? "Err",
                    count: activeData?.totalCount.toString() ?? "Err"),
              ),
              Flexible(
                child: buildActvInactvCardLabelCount(
                    label: inActiveData?.label ?? "Err",
                    count: inActiveData?.totalCount.toString() ?? "Err"),
              ),
            ],
          ).padSymmetric(horizontalPad: 24),
          Container(
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                LineGraph(
                  graphType: GraphType.inActive,
                  data: data,
                ),
                LineGraph(
                  graphType: GraphType.active,
                  data: data,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActvInactvCardLabelCount({
    required String label,
    required String count,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        12.verticalSpace,
        Text(
          count,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.bodyLarge?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildThisMonthOrTodayCard({
    required String label,
    required String count,
    required DashboardResponseData data,
    required GraphType graphType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFBE7ED),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  size: 30,
                  color: Colors.green,
                ).padSymmetric(
                  verticalPad: 12,
                  horizontalPad: 3,
                ),
              ),
              6.horizontalSpace,
              Flexible(
                child: Column(
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    3.verticalSpace,
                    Text(
                      count,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).padSymmetric(horizontalPad: 12, verticalPad: 6),
          SizedBox(
            height: 20,
            child: LineGraph(
              graphType: graphType,
              data: data,
            ),
          )
        ],
      ),
    );
  }

  Widget buildProgressByMonthCard(DashboardResponseData data) {
    final list = data.monthWiseProgress?.data ?? [];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Progress by month",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          25.verticalSpace,
          ...list.map(
            (item) => Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    6.horizontalSpace,
                    Flexible(
                      child: Container(
                        height: 15,
                        width: item.value / 5.0,
                        decoration: BoxDecoration(
                          color: Color(int.tryParse(item.color) ?? 0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    6.horizontalSpace,
                    Flexible(
                      child: Text(
                        item.value.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                28.verticalSpace,
              ],
            ),
          ),
        ],
      ).padAll(value: 12),
    );
  }

  Widget buildListItem(DashboardResponseData data) {
    final list = data.lists;
    if (list.isEmpty) {
      return buildCommonContainer(
        child: Center(
          child: Text(
            "No data found",
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ).padAll(value: 12),
        ),
      ).padSymmetric(horizontalPad: 12).toSliverBox;
    }
    return SliverList.builder(
      itemCount: 2 * list.length,
      itemBuilder: (_, index) {
        final item = list[index ~/ 2];
        if (index % 2 == 1) {
          return 12.verticalSpace;
        }
        return buildCommonContainer(
          borderRadius: 28,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff3096F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  Assets.addContactsIcon,
                  width: 30,
                  height: 30,
                ).padAll(value: 12),
              ),
              12.horizontalSpace,
              Expanded(
                flex: 3,
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              6.horizontalSpace,
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        item.count.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).padAll(value: 12),
        ).padSymmetric(horizontalPad: 12);
      },
    );
  }

  Widget buildCommonContainer({
    required Widget child,
    double? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          color: Colors.white,
          border: Border.all()),
      child: child,
    );
  }
}
