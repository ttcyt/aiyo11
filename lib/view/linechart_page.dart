import 'dart:async';
import 'package:aiyo11/component/bmi.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aiyo11/component/bmi_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/services/account.dart';
import 'package:lottie/lottie.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Jan';
      break;
    case 1:
      text = 'Feb';
      break;
    case 2:
      text = 'Mar';
      break;
    case 3:
      text = 'Apr';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'Jun';
      break;
    case 6:
      text = 'Jul';
      break;
    case 7:
      text = 'Aug';
      break;
    case 8:
      text = 'Sep';
      break;
    case 9:
      text = 'Oct';
      break;
    case 10:
      text = 'Nov';
      break;
    case 11:
      text = 'Dec';
      break;
    default:
      return Container();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 10:
      text = '10';
      break;
    case 15:
      text = '15';
      break;
    case 20:
      text = '20';
      break;

    case 25:
      text = '25';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

const TextStyle style = TextStyle(
  fontFamily: 'PS',
  fontSize: 28,
);
const TextStyle styles = TextStyle(
  fontFamily: 'PS',
  fontSize: 23,
);

List<Color> colors = [Colors.red, Colors.purple, Colors.blue];
FlTitlesData titles = const FlTitlesData(
  leftTitles: AxisTitles(
    axisNameWidget: Text('BMI'),
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: leftTitleWidgets,
    ),
  ),
  bottomTitles: AxisTitles(
    axisNameWidget: Text('time'),
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: bottomTitleWidgets,
    ),
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: false,
    ),
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: false,
    ),
  ),
);

class LinechartPage extends StatefulWidget {
  LinechartPage({super.key, required this.email});

  final String email;

  @override
  State<LinechartPage> createState() => _LinechartPageState();
}

class _LinechartPageState extends State<LinechartPage>
    with TickerProviderStateMixin {
  late int id;
  List<BMI> BMIs = [];
  final _firestore = FirebaseFirestore.instance;
  List<double> heights = [];
  List<double> weights = [];
  List<Timestamp> dates = [];
  List<int> ids = [];
  List<double> bmis = [];
  List<FlSpot> flspots = [];

  // late final AnimationController _animationController;
  bool isVisible = true;

  Future<void> updateBMIs() async {
    BMIs;
    BMIs = AccountServices.takeBMIs();
    flspots = AccountServices.takeSpot();
    id = AccountServices.heights.length;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _animationController = AnimationController(vsync: this);
    updateBMIs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Check your BMI ~',
              style: style,
            ),
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 2.0,
                child: LineChart(
                  LineChartData(
                    titlesData: titles,
                    minX: 0,
                    maxX: 11,
                    minY: 15,
                    maxY: 25,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        spots: flspots,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: BMIs.length,
                  itemBuilder: (context, index) {
                    return BMIcard(
                      height: BMIs[index].height,
                      heightChanged: (height) => setState(() {
                        BMIs[index].height = height;
                      }),
                      weight: BMIs[index].weight,
                      weightChanged: (weight) => setState(() {
                        BMIs[index].weight = weight;
                      }),
                      id: BMIs[index].id,
                      date: BMIs[index].date,
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
                  bmis.add(bmi.calculateBmi());
                  ids.add(bmi.id);
                }
                print(heights[0]);

                final data =
                    _firestore.collection('BMIs').doc('${widget.email}');
                data.set({
                  'heights': heights,
                  'weights': weights,
                  'dates': dates,
                  'ids': ids,
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Text(
                'Save',
                style: styles,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(BMIs.length);
          print(id);
          id++;
          BMIs.add(
            BMI(
              id: id,
              date: DateTime.now(),
              height: 160,
              weight: 55,
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
