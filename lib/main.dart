import 'package:aiyo11/view/line_chart_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aiyo11/firebase_options.dart';
import 'package:flutter/material.dart';
import 'view/login_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Aiyo());
}

class Aiyo extends StatelessWidget {
  const Aiyo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LineChartPage(),
    );
  }
}
