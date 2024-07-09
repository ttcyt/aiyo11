import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

List<Color> colorsDecrease = [
  Colors.red,
  Colors.purpleAccent,
  Colors.lightBlue
];
List<Color> colorsIncrease = [
  Colors.lightBlue,
  Colors.purpleAccent,
  Colors.red
];

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 200,
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.0,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                      axisNameWidget: Text('time'),
                    ),
                    leftTitles: AxisTitles(
                        axisNameWidget: Text('BMI'),
                        sideTitles: SideTitles(
                          showTitles: true,
                        )),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 4),
                        FlSpot(2, 5),
                        FlSpot(3, 8),
                        FlSpot(4, 2),
                      ],
                      gradient: LinearGradient(colors: colorsIncrease),
                      isCurved: true,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: Row(
                  children: [
                    Text('1'),
                    TextField(
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'height',
                      ),
                    ),
                    TextField(
                      maxLength: 10,
                      decoration: InputDecoration(
                          hintText: 'weight'
                      ),
                    ),
                    Text('BMI：')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
