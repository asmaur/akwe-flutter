import 'package:akwe/src/models/app_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({
    super.key,
    this.dataSource,
  });
  final List<ChartData>? dataSource;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;
  List<Color> chartColors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.lightGreen,
    Colors.pinkAccent,
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.dataSource);
    return Container(
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            // Expanded(
            //
            //   child: ListView(
            //     children: <Widget>[
            //         Indicator(
            //           color: chartColors[0],
            //           text: 'One',
            //           isSquare: false,
            //           size: touchedIndex == 0 ? 18 : 16,
            //           textColor: touchedIndex == 0
            //               ? chartColors[0]
            //               : chartColors[0],
            //         ),
            //         Indicator(
            //           color: chartColors[1],
            //           text: 'Two',
            //           isSquare: false,
            //           size: touchedIndex == 1 ? 18 : 16,
            //           textColor: touchedIndex == 1
            //               ? chartColors[1]
            //               : chartColors[1],
            //         ),
            //         Indicator(
            //           color: chartColors[2],
            //           text: 'Three',
            //           isSquare: false,
            //           size: touchedIndex == 2 ? 18 : 16,
            //           textColor: touchedIndex == 2
            //               ? chartColors[2]
            //               : chartColors[2],
            //         ),
            //         Indicator(
            //           color: chartColors[3],
            //           text: 'Four',
            //           isSquare: false,
            //           size: touchedIndex == 3 ? 18 : 16,
            //           textColor: touchedIndex == 3
            //               ? chartColors[3]
            //               : chartColors[3],
            //         ),
            //       ],
            //
            //   ),
            //
            //   // child: Column(
            //   //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   //   children: <Widget>[
            //   //     Indicator(
            //   //       color: chartColors[0],
            //   //       text: 'One',
            //   //       isSquare: false,
            //   //       size: touchedIndex == 0 ? 18 : 16,
            //   //       textColor: touchedIndex == 0
            //   //           ? chartColors[0]
            //   //           : chartColors[0],
            //   //     ),
            //   //     Indicator(
            //   //       color: chartColors[1],
            //   //       text: 'Two',
            //   //       isSquare: false,
            //   //       size: touchedIndex == 1 ? 18 : 16,
            //   //       textColor: touchedIndex == 1
            //   //           ? chartColors[1]
            //   //           : chartColors[1],
            //   //     ),
            //   //     Indicator(
            //   //       color: chartColors[2],
            //   //       text: 'Three',
            //   //       isSquare: false,
            //   //       size: touchedIndex == 2 ? 18 : 16,
            //   //       textColor: touchedIndex == 2
            //   //           ? chartColors[2]
            //   //           : chartColors[2],
            //   //     ),
            //   //     Indicator(
            //   //       color: chartColors[3],
            //   //       text: 'Four',
            //   //       isSquare: false,
            //   //       size: touchedIndex == 3 ? 18 : 16,
            //   //       textColor: touchedIndex == 3
            //   //           ? chartColors[3]
            //   //           : chartColors[3],
            //   //     ),
            //   //   ],
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<Color> chartColors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.lightGreen,
      Colors.pinkAccent
    ];
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        // const color0 = AppColors.contentColorBlue;
        // const color1 = AppColors.contentColorYellow;
        // const color2 = AppColors.contentColorPink;
        // const color3 = AppColors.contentColorGreen;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: chartColors[i],
              value: 10,
              title: '10',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: chartColors[i], width: 6)
                  : BorderSide(color: chartColors[i].withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: chartColors[i],
              value: 45,
              title: '45',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: chartColors[i], width: 6)
                  : BorderSide(color: chartColors[i].withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: chartColors[i],
              value: 30,
              title: '30',
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: chartColors[i], width: 6)
                  : BorderSide(color: chartColors[i].withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: chartColors[i],
              value: 5,
              title: '5',
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: chartColors[i], width: 6)
                  : BorderSide(color: chartColors[i].withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
