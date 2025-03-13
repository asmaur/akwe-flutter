
import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/report/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

import 'report_page_controller.dart';

class ReportPage extends StatefulWidget {
  ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int touchedIndex = -1;

  final ReportPageController _controller = Get.put(ReportPageController());

  @override
  Widget build(BuildContext context) {
    final ReportPageController controller = Get.find<ReportPageController>();

    return DefaultTabController(
      length: 2,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text(translation.appMetricTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
            bottom: TabBar(
              indicatorColor: AppColors.appMidGreen,
              isScrollable: true,
              controller: controller.controller,
              tabs: controller.graphTabs,
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         openBottomSheet(context);
            //       },
            //       icon: Icon(
            //         FontAwesomeIcons.calendarWeek,
            //         size: AppLayout.getHeight(20),
            //       )),
            //   IconButton(
            //     onPressed: () => {
            //       showModalBottomSheet<dynamic>(
            //           isScrollControlled: true,
            //           context: context,
            //           builder: (BuildContext bc) {
            //             return Container(
            //               height: AppLayout.getScreenHeight() * .7,
            //               //margin: EdgeInsets.only(bottom: 100);
            //             );
            //           })
            //     },
            //     icon: const Icon(Icons.info_outline),
            //   )
            // ],
          ),
          body: TabBarView(
            controller: controller.controller,
            children: [
              Column(
                children: [
                  Gap(AppLayout.getHeight(10)),
                  SizedBox(
                    height: AppLayout.getHeight(30),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.metricNavItems.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {

                              controller.selectedMetricItem.value = index;
                              controller.getSelectedFilter(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getHeight(20),
                                  vertical: 0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getHeight(5)),
                              decoration: BoxDecoration(
                                color: controller.selectedMetricItem.value ==
                                        index
                                    ? AppColors.appDarkGreen
                                    : AppColors.appMidGreen,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  controller.metricNavItems[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: AppLayout.getHeight(10),
                                          color: AppColors.appWhite),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(AppLayout.getHeight(120)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 1,
                          centerSpaceRadius: 40,
                          sections: getSections(touchedIndex),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(90),
                  ),
                  Flexible(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.chartData.length,
                        itemBuilder: (context, index) {
                          return Indicator(
                              data: controller.chartData[index],
                              isSquare: false,);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Gap(AppLayout.getHeight(10)),
                  SizedBox(
                    height: AppLayout.getHeight(30),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.fluxNavItems.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                                controller.selectedFluxItem.value = index;
                                controller.getSelectedFluxFilter(index);

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getHeight(20),
                                  vertical: 0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getHeight(5)),
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedFluxItem.value == index
                                        ? AppColors.appDarkGreen
                                        : AppColors.appMidGreen,
                                borderRadius: BorderRadius.circular(
                                    AppLayout.getHeight(15)),
                              ),
                              child: Center(
                                child: Text(
                                  controller.fluxNavItems[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: AppLayout.getHeight(10),
                                          color: AppColors.appWhite),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: Center(
                        child: SizedBox(
                          width: AppLayout.getScreenWidth() * 0.9,
                          height: AppLayout.getScreenHeight() * 0.5,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                  // tooltipBgColor: AppColors.appWhite,
                                  //getTooltipColor: (LineTouchTooltipData) => AppColors.appWhite,
                                  tooltipRoundedRadius: 4.0,
                                  showOnTopOfTheChartBoxArea: false,
                                  fitInsideHorizontally: true,
                                  getTooltipItems: (dummyData2) {
                                    return dummyData2.map(
                                      (LineBarSpot touchedSpot) {
                                        const textStyle = TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.appBlack,
                                          height: 1.4,
                                        );
                                        return LineTooltipItem(
                                          '${DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt()))} \n ${touchedSpot.y}',
                                          textStyle,
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false,
                                          getTitlesWidget: getBottomTitles))),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: controller.lineChartInfo.isEmpty
                                      ? [const FlSpot(0, 0)]
                                      : controller.lineChartInfo,
                                  isCurved: true,
                                  barWidth: 3,
                                  color: Colors.blue,
                                  // dotData: FlDotData(
                                  //   show: false,
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    final ReportPageController controller = Get.find<ReportPageController>();

    Get.bottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      //isScrollControlled: true,
      enableDrag: true,
      Column(
        children: [
          SizedBox(height: AppLayout.getHeight(20)),
          Center(
            child: Container(
              child: Text(
                translation.appMetricFilterByPeriodLabel.tr,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                    ),
              ),
            ),
          ),
          //Divider(height: 3,),

          //Gap(5),

          Form(
            child: Column(
              children: [
                SizedBox(
                  width: AppLayout.getScreenWidth() * 0.8,
                  child: TextFormField(
                    controller: controller.startDate,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText:
                            translation.appMetricFilterByPeriodFromLabel.tr),
                    //maxLength: 20,
                    onTap: () async {
                      controller.pickDateRange(context);
                    },
                  ),
                ),
                //Gap(10),
                SizedBox(
                  width: AppLayout.getScreenWidth() * 0.8,
                  child: TextFormField(
                    controller: controller.endDate,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText:
                            translation.appMetricFilterByPeriodToLabel.tr),
                    onTap: () async {
                      controller.pickDateRange(context);
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: AppLayout.getScreenWidth() * 0.7,
              padding: EdgeInsets.only(
                  top: AppLayout.getHeight(20),
                  bottom: AppLayout.getHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.appRed)),
                    child: Text(
                      translation.appMetricFilterByPeriodCancelLabel.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.appRed),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.appRed,
                        side: const BorderSide(color: Colors.transparent)),
                    child:
                        Text(translation.appMetricFilterByPeriodFilterLabel.tr),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    //         (Set<MaterialState> states) {
                    //       if (states.contains(MaterialState.pressed)) {
                    //         return AppColors.appRed;
                    //       }
                    //       return AppColors.appRed;
                    //     },
                    //   ),
                    //   shape: MaterialStateProperty.all(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //       side: const BorderSide(color: AppColors.appRed, width: 0)
                    //     )
                    //   )
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<PieChartSectionData> getSections(int touchedIndex) {
    return _controller.chartData
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final double fontSize = isTouched ? 25 : 8;
          final double radius = isTouched ? 100 : 80;

          final value = PieChartSectionData(
            color: data.color,
            value: data.value,
            title: '${data.percent}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    return Text(DateFormat()
        .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())));
  }
}
