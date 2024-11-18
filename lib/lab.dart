import 'package:aiyo11/view/camera_page.dart';
import 'package:aiyo11/view/linechart_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:aiyo11/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Lab());
}

class Lab extends StatefulWidget {
  const Lab({super.key});

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: NavigateButton(),
        ),
      ),
    );
  }
}

class NavigateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        List<CameraDescription> cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LineChartPage(email:"ttcyt1029@gmail.com")
            ),
          );
        }
      },
      child: const Text('Navigate to Camera Page'),
    );
  }
}