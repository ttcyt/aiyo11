import 'dart:async';
import 'package:aiyo11/component/bmi.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aiyo11/component/bmi_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/services/account.dart';
import 'package:aiyo11/widget/chart_title_widgets.dart';

const TextStyle style = TextStyle(
  fontFamily: 'PS',
  fontSize: 28,
);
const TextStyle styles = TextStyle(
  fontFamily: 'PS',
  fontSize: 23,
);

List<Color> colors = [Colors.red, Colors.purple, Colors.blue];


class LineChartPage extends StatefulWidget {
  LineChartPage({super.key, required this.email});

  final String email;

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage>
    with TickerProviderStateMixin {
  AccountServices accountServices = AccountServices();
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
    await accountServices.fetchAccounts();
    print('${accountServices.bmiDatas}   bmidatas');
    BMIs = await accountServices.takeBMIs();
    flspots = await accountServices.takeSpot();
    id = accountServices.heights.length;
    print(BMIs[0].height);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBMIs();
    print(bmis);
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
            SizedBox(
              height: 50,
              width: 100,
            ),
            Container(
              height: 300,
              width: 300,
              child: LineChartOfBMI(flspots: flspots),
            ),
            const SizedBox(
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

class LineChartOfBMI extends StatelessWidget {
  const LineChartOfBMI({
    super.key,
    required this.flspots,
  });

  final List<FlSpot> flspots;

  @override
  Widget build(BuildContext context) {
    return LineChart(
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
    );
  }
}
