import 'package:aiyo11/services/account.dart';
import 'package:aiyo11/services/exercise.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aiyo11/services/timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key,required this.cameras, required this.pose});
  List<CameraDescription> cameras;
  int pose;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final AccountServices accountService = AccountServices();
  ExerciseTimeStorage exerciseTimeStorage = ExerciseTimeStorage(email: AccountServices().email!);
  List<CameraDescription> cameras = [];
  late CameraController cameraController;
  final ImagePicker imagePicker = ImagePicker();
  String path = '';
  int id = 10;
  TimerService timerService = TimerService();
  bool isStart = false;
  List<int> exerciseTimes = [];


  @override
  void initState() {
    super.initState();
    init();
    // print(exerciseTimes);
    startCamera();

  }

  Future<void> init() async {
    await exerciseTimeStorage.getData();
    exerciseTimes = exerciseTimeStorage.fetchExerciseTime(DateTime.now());
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
                onTap: () async {
                  XFile picture = await cameraController.takePicture();
                  if(isStart == false) {
                    init();
                    print('========');
                    isStart = true;
                    print(exerciseTimes);
                    setState(() {

                    });
                  }else{
                    isStart = false;
                    int exerciseTime = timerService.getElapsedTime();
                    exerciseTimes[widget.pose] += exerciseTime;
                    exerciseTimeStorage.saveExerciseTime(exerciseTimes);
                    timerService.reset();
                    setState(() {

                    });
                  } },
                child: isStart? button(const Icon(Icons.stop), Alignment.bottomCenter):
                button(const Icon(Icons.not_started_outlined), Alignment.bottomCenter)
            ),
            Column(
              children: [
                Text('${timerService.getElapsedTime()}')
              ],
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

Widget button(Icon icon, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
        ],
      ),
      child: icon,
    ),
  );
}


// XFile? image =
//     await imagePicker.pickImage(source: ImageSource.camera);
// setState(() {
//   if (image != null) {
//     path = image.path;
//     print(path);
//   }
// });
// File file = File(image!.path);
// await _store.ref('image/$id.png').putFile(File(file.path));
// id++;
//
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => ImagePage(image: image!)));
