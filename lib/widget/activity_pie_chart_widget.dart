import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aiyo11/widget/constant.dart';
import 'package:aiyo11/widget/size_config.dart';

class ActivityPieChart extends StatefulWidget {
  final List<String> poseNames;
  final List<int> exerciseTimes;

  const ActivityPieChart({required this.poseNames, required this.exerciseTimes});

  @override
  _ActivityPieChartState createState() => _ActivityPieChartState();
}

class _ActivityPieChartState extends State<ActivityPieChart> {
  int _touchedIndex = -1;
  int totalExerciseTime() {
    int total = 0;
    for (int i = 0; i < widget.exerciseTimes.length; i++) {
      total += widget.exerciseTimes[i];
      print(total);
    }
    return total;
  }

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
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.poseNames.length,
                            itemBuilder: (context, index) {
                          return Text(
                            ' ◆ ${widget.poseNames[index]}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18, // 調整字大小
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
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
    return List.generate(6, (i) {
      final isTouched = i == _touchedIndex;
      //final double fontSize = isTouched ? 30 : 12;
      final double radius = isTouched ? 30 : 20;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: CustomColors.kLightPinkColor,
              value: widget.exerciseTimes[0]/totalExerciseTime(),
              title: widget.poseNames[0],
              radius: radius);
        case 1:
          return PieChartSectionData(
              color: CustomColors.kPrimaryColor,
              value: widget.exerciseTimes[1]/totalExerciseTime(),
              title: widget.poseNames[1],
              radius: radius);
        case 2:
          return PieChartSectionData(
              color: CustomColors.kCyanColor,
              value: widget.exerciseTimes[2]/totalExerciseTime(),
              title: widget.poseNames[2],
              radius: radius);
        case 3:
          return PieChartSectionData(
              color: CustomColors.kYellowColor,
              value: widget.exerciseTimes[3]/totalExerciseTime(),
              title: widget.poseNames[3],
              radius: radius);
        case 4:
          return PieChartSectionData(
              color: CustomColors.kPurpleColor,
              value: widget.exerciseTimes[4]/totalExerciseTime(),
              title: widget.poseNames[4],
              radius: radius);
        case 5:
          return PieChartSectionData(
              color: CustomColors.kLightColor,
              value: widget.exerciseTimes[5]/totalExerciseTime(),
              title: widget.poseNames[5],
              radius: radius);
        default:
          return PieChartSectionData(
              color: Colors.grey, value: 0, title: '', radius: 0);
      }
    });
  }
}
