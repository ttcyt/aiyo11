import 'dart:async';
import 'package:aiyo11/component/bmi.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aiyo11/component/bmi_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/services/account.dart';

List<Color> colors = [Colors.red, Colors.purple, Colors.blue];
FlTitlesData titles = const FlTitlesData(
  leftTitles: AxisTitles(
    axisNameWidget: Text('BMI'),
    sideTitles: SideTitles(
      showTitles: true,
    ),
  ),
  bottomTitles: AxisTitles(
    axisNameWidget: Text('time'),
    sideTitles: SideTitles(
      showTitles: true,
    ),
  ),
);

class LinechartPage extends StatefulWidget {
  LinechartPage({super.key, required this.email});

  final String email;

  @override
  State<LinechartPage> createState() => _LinechartPageState();
}

class _LinechartPageState extends State<LinechartPage> {
  List<BMI> BMIs = [];
  int id = 0;
  final _firestore = FirebaseFirestore.instance;
  List<double> heights = [];
  List<double> weights = [];
  List<Timestamp> dates =[];

  void updateBMIs() async {
    BMIs = await AccountServices.takeBMIs();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBMIs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 2.0,
                child: LineChart(
                  LineChartData(titlesData: titles, lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: colors,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      spots: [
                        const FlSpot(1, 2),
                        const FlSpot(2, 4),
                        const FlSpot(3, 5),
                        const FlSpot(4, 8),
                        const FlSpot(5, 7),
                        const FlSpot(6, 2),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: BMIs.length,
                  itemBuilder: (context, index) {
                    return BMIcard(
                      id: BMIs[index].id,
                      date: BMIs[index].date,
                      height: BMIs[index].height,
                      weight: BMIs[index].weight,
                      bmi: BMIs[index].calculateBmi(),
                    );
                  }),
            ),
            TextButton(
              onPressed: () {

                for (BMI bmi in BMIs) {
                  heights.add(bmi.height);
                  weights.add(bmi.weight);
                  dates.add(Timestamp.fromDate(bmi.date));
                }
                print(heights[0]);

                final data =
                    _firestore.collection('BMIs').doc('${widget.email}');
                data.set({
                  'heights': heights,
                  'weights': weights,
                  'dates': dates,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          id++;
          BMIs.add(
            BMI(
              id: id,
              date: DateTime.now(),
              height: 160.0,
              weight: 55.0,
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
