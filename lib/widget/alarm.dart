import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final InitializationSettings initializationSettings =
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _scheduleNotification() {
    if (_selectedDate != null) {
      final DateTime scheduledDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '運動提醒',
        '是時候運動了！',
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      // 顯示設置成功的通知
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('鬧鐘已設置成功！'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // 提示用戶需要選擇日期
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('請選擇日期！'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定鬧鐘提醒'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '選擇鬧鐘時間:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('選擇時間'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('選擇日期'),
            ),
            const SizedBox(height: 20),
            Text(
              '選中的時間: ${_selectedTime.format(context)}',
              style: const TextStyle(fontSize: 18),
            ),
            if (_selectedDate != null)
              Text(
                '選中的日期: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleNotification,
              child: const Text('設定鬧鐘'),
            ),
          ],
        ),
      ),
    );
  }
}
