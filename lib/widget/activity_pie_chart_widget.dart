import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aiyo11/widget/constant.dart';
import 'package:aiyo11/widget/size_config.dart';

class ActivityPieChart extends StatefulWidget {
  @override
  _ActivityPieChartState createState() => _ActivityPieChartState();
}

class _ActivityPieChartState extends State<ActivityPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: true),
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    startDegreeOffset: 30,
                    sections: _generateSections(),
                    pieTouchData: PieTouchData(
                      touchCallback:
                          (FlTouchEvent event, PieTouchResponse? response) {
                        setState(() {
                          if (event is FlLongPressEnd ||
                              event is FlPanEndEvent) {
                            _touchedIndex = -1;
                          } else {
                            // Handle other touch events
                            if (response != null &&
                                response.touchedSection != null) {
                              _touchedIndex =
                                  response.touchedSection!.touchedSectionIndex;
                            } else {
                              _touchedIndex = -1;
                            }
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 左對齊
                    children: [
                      Text(
                        ' ◆ 三角式',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18, // 調整字大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10), // 控制文字之間的間距
                      Text(
                        ' ◆ 樹式',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18, // 調整字大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10), // 控制文字之間的間距
                      Text(
                        ' ◆ 下犬式',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18, // 調整字大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      //final double fontSize = isTouched ? 30 : 12;
      final double radius = isTouched ? 30 : 20;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: CustomColors.kLightPinkColor,
              value: 33.33,
              title: '',
              radius: radius);
        case 1:
          return PieChartSectionData(
              color: CustomColors.kPrimaryColor,
              value: 33.33,
              title: '',
              radius: radius);
        case 2:
          return PieChartSectionData(
              color: CustomColors.kCyanColor,
              value: 33.33,
              title: '',
              radius: radius);
        default:
          return PieChartSectionData(
              color: Colors.grey, value: 0, title: '', radius: 0);
      }
    });
  }
}
