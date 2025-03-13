import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:timelines_plus/timelines_plus.dart';
import 'budget_full_page_controller.dart';

class BudgetFullPage extends StatefulWidget {
  const BudgetFullPage({super.key});

  @override
  State<BudgetFullPage> createState() => _BudgetFullPageState();
}

class _BudgetFullPageState extends State<BudgetFullPage> {
  late int showingTooltip;
  final _controller = Get.find<BudgetFullPageController>();
  final locale = Get.deviceLocale;

  final currency = NumberFormat.currency(
    locale: Get.deviceLocale?.languageCode,
    symbol: NumberFormat.simpleCurrency(locale: Get.deviceLocale?.languageCode)
        .currencySymbol,
    decimalDigits: 2,
  );

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 2,
      child: Obx(() => Scaffold(
        appBar: AppBar(
          title: Text(translation.userBudgetDetailTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
          actions: [
            IconButton(onPressed: (){
              _controller.deleteBudget();
            }, icon: const Icon(Icons.delete_forever_outlined))
          ],
          bottom: TabBar(
            tabs: [
              Tab(child: Text(translation.userBudgetFilterHistoric.tr),),
              Tab(child: Text(translation.userBudgetFilterPerformance.tr),),
            ],
          ),
        ),

          body: _controller.isLoading.value
              ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.appDarkGreen
                    : Colors.white,
              ),) : TabBarView(
            //controller: _controller.tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(AppLayout.getHeight(10)),
                    Card(
                      child: Column(
                        children: [
                          Gap(AppLayout.getHeight(5)),
                          Center(
                            child: Text(translation.userBudgetDetailHistory.tr),
                          ),

                        ],
                      ),
                    ),
                    Gap(AppLayout.getHeight(10)),
                    _controller.budget.value.histories != null
                        ? FixedTimeline.tileBuilder(
                      builder: TimelineTileBuilder.connectedFromStyle(
                        contentsAlign: ContentsAlign.alternating,
                        contentsBuilder: (context, index) => Padding(
                          padding:
                          EdgeInsets.all(AppLayout.getHeight(24)),
                          child: Container(
                            color: _controller.budget.value
                                .histories![index].percent! <
                                50
                                ? AppColors.appDarkGreen
                                : (_controller.budget.value
                                .histories![index].percent! <
                                70
                                ? AppColors.appYellow
                                : AppColors.appRed),
                            padding:
                            EdgeInsets.all(AppLayout.getHeight(5)),
                            child: Column(
                              children: [
                                Text(
                                  "${currency.format(_controller.budget.value.histories![index].expense!)}(${_controller.budget.value.histories![index].percent!}%)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(_controller
                                      .budget
                                      .value
                                      .histories![index]
                                      .creationDate!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        connectorStyleBuilder: (context, index) {
                          return ConnectorStyle.dashedLine;
                        },
                        indicatorStyleBuilder: (context, index) =>
                        IndicatorStyle.dot,
                        itemCount:
                        _controller.budget.value.histories!.length,
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
              SingleChildScrollView(child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Gap(AppLayout.getHeight(5)),

                        Center(
                          child: Text(translation.appPerformanceSummaryLabel.tr),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(translation.appPerformanceBudgetLabel.tr),
                          trailing: Text(currency
                              .format(_controller.budget.value.initialBalance),),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(translation.appPerformanceBalanceLabel.tr),
                          trailing: Text(
                              currency.format(_controller.budget.value.balance)),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(translation.appPerformanceExpenseLabel.tr),
                          trailing: Text(
                            currency.format(_controller.budget.value.expenses),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(translation.appPerformanceIncomeLabel.tr),
                          trailing: Text(
                            currency.format(_controller.budget.value.incomes),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(AppLayout.getHeight(20)),

                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: AppLayout.getHeight(18), bottom: AppLayout.getHeight(15)),
                      child: SizedBox(
                        height: AppLayout.getHeight(300),
                        width: AppLayout.getScreenWidth() * 0.9,
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Obx(
                                () => BarChart(
                              BarChartData(
                                borderData: FlBorderData(show: true),
                                titlesData: FlTitlesData(
                                    show: true,
                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles,))
                                ),
                                barGroups: [
                                  generateGroupData(
                                    1,
                                    _controller.budget.value.initialBalance!
                                        .toInt() == 0 ? _controller.budget.value.balance!.toInt() * -2 : _controller.budget.value.initialBalance!
                                        .toInt(),
                                    Colors.teal,
                                  ),
                                  generateGroupData(
                                    2,
                                    _controller.budget.value.balance!.toInt()*-1,
                                    _controller.budget.value.balance!.toInt() > 0
                                        ? Colors.cyan
                                        : Colors.orange,
                                  ),
                                  generateGroupData(
                                    3,
                                    -_controller.budget.value.expenses!.toInt(),
                                    Colors.redAccent,
                                  ),
                                  generateGroupData(
                                    4,
                                    _controller.budget.value.incomes!.toInt(),
                                    Colors.blue,
                                  ),
                                ],
                                barTouchData: BarTouchData(
                                    enabled: true,
                                    handleBuiltInTouches: false,
                                    touchCallback: (event, response) {
                                      if (response != null &&
                                          response.spot != null &&
                                          event is FlTapUpEvent) {
                                        setState(() {
                                          final x =
                                              response.spot!.touchedBarGroup.x;
                                          final isShowing = showingTooltip == x;
                                          if (isShowing) {
                                            showingTooltip = -1;
                                          } else {
                                            showingTooltip = x;
                                          }
                                        });
                                      }
                                    },
                                    mouseCursorResolver: (event, response) {
                                      return response == null ||
                                          response.spot == null
                                          ? MouseCursor.defer
                                          : SystemMouseCursors.click;
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ), ),
            ],
          ),

      ), ),
    );
  }

  BarChartGroupData generateGroupData(int x, int y, Color color) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            color: color,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _controller.budget.value.initialBalance!,
              color: Colors.grey,//[300],
            )
        ),
      ],
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta){
    var style = TextStyle(
        fontSize: AppLayout.getHeight(12),
        fontWeight: FontWeight.w600
    );

    Widget text;
    switch(value.toInt()){
      case 1:
        text = Text(translation.appPerformanceBudgetLabel.tr, style: style,);
        break;
      case 2:
        text = Text(translation.appPerformanceBalanceLabel.tr, style: style);
        break;

      case 3:
        text = Text(translation.appPerformanceExpenseLabel.tr, style: style,);
        break;
      case 4:
        text = Text(translation.appPerformanceIncomeLabel.tr, style: style);
        break;
      default:
        text = const Text("");
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);

  }
}
