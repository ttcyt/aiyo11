import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aiyo11/component/bmi.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Account {
  int id;
  String name;
  String email;
  String gender;
  double height;
  double weight;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.weight,
    required this.height,
    required this.gender,
  });
}

class AccountServices {
  static final _firestore = FirebaseFirestore.instance;
  static String? email = _fetchEmail();
  static Map<String, dynamic> _account = {};

  static Map<String, dynamic> get account => _account;
  static Map<String, dynamic> _bmiDatas = {};

  static Map<String, dynamic> get bmiDatas => _bmiDatas;
  static List<dynamic> heights = [];
  static List<dynamic> weights = [];
  static List<dynamic> dates = [];
  static List<dynamic> ids = [];
  static List<BMI> bmis = [];

  static Future<void> fetchAccounts() async {
    dynamic source = await _firestore.collection('users').doc(email).get();
    dynamic data = source.data();
    _account = data;
    print(email);
    print(_account['name']);

    dynamic bmiSource = await _firestore.collection('BMIs').doc(email).get();
    dynamic bmiData = bmiSource.data();
    _bmiDatas = bmiData;
    // heights.clear();
    // weights.clear();
    // dates.clear();
    // bmis.clear();
    // ids.clear();

    heights = _bmiDatas['heights'];
    weights = _bmiDatas['weights'];
    dates = _bmiDatas['dates'];
    ids = _bmiDatas['ids'];
  }

  static List<BMI> takeBMIs() {
    bmis.clear();
    for (int i = 0; i < heights.length; i++) {
      bmis.add(
        BMI(
          date: dates[i].toDate(),
          id: i + 1,
          height: double.parse(heights[i].toString()),
          weight: double.parse(weights[i].toString()),
        ),
      );
    }
    return bmis;
  }

  static List<FlSpot> takeSpot() {
    List<FlSpot> flspots = [];
    for (BMI bmi in bmis) {
      int month = bmi.date.month;
      print(month);
      int day = bmi.date.day;
      double x = month + (day / 31) - 1;
      double y = double.parse(bmi.calculateBmi().toStringAsFixed(2));
      flspots.add(FlSpot(x, y));
    }

    return flspots;
  }

  static String? _fetchEmail() {
    final auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    return email;
  }
}
