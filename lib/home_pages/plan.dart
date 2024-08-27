import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aiyo11/widget/constant.dart';
import 'package:aiyo11/widget/size_config.dart';
import 'package:aiyo11/widget/activity_pie_chart_widget.dart';
import 'package:aiyo11/widget/weekly_bar_chart_widget.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  DateTime selectedDate = DateTime.now(); // 当前选择的日期
  List<int> weeklyData = [30, 42, 44, 36, 20, 56, 34];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // 初始化 SizeConfig
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMonthSection(),
                _buildDateSection(),
                SizedBox(height: 20),
                Text(
                  " EXERCISE TIME",
                  style: TextStyle(
                    color: Color(0xFF6563A5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ActivityPieChart(),
                SizedBox(height: 20),
                Text(
                  " GOAL COMPLIANCE",
                  style: TextStyle(
                    color: Color(0xFF6563A5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WeeklyBarChartWidget(
                  weeklyData: weeklyData,
                  maximumValueOnAxis: 65,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildMonthSection() {
    String monthName = DateFormat.MMMM().format(selectedDate); // 获取月份名称
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6563A5),
        ),
      ),
    );
  }

  Container _buildDateSection() {
    List<DateTime> weekDates = _getWeekDates(selectedDate);
    return Container(
      height: SizeConfig.blockSizeVertical * 13,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: weekDates.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          DateTime date = weekDates[index];
          int dayValue = date.weekday;
          String dayName = DateFormat.E().format(date); // 获取星期的缩写
          String dayNumber = DateFormat.d().format(date); // 获取日期
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
                // 更新数据逻辑可以在这里实现
                // 例如，根据selectedDate加载相关的数据
              });
            },
            child: Container(
              padding: EdgeInsets.all(6.0),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: dayValue == selectedDate.weekday
                          ? CustomColors.kPrimaryColor
                          : selectedDate.weekday < dayValue
                          ? CustomColors.kLightColor
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  CircleAvatar(
                    backgroundColor: dayValue == selectedDate.weekday
                        ? CustomColors.kPrimaryColor
                        : Colors.transparent,
                    child: Text(
                      dayNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: dayValue >= selectedDate.weekday
                            ? CustomColors.kLightColor
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> _getWeekDates(DateTime currentDate) {
    int currentWeekday = currentDate.weekday;
    DateTime firstDayOfWeek =
    currentDate.subtract(Duration(days: currentWeekday - 1));
    return List.generate(
        7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }
}
