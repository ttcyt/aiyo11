import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aiyo11/view/image_page.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key,required this.cameras});
  List<CameraDescription> cameras;
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras = [];
  late CameraController cameraController;
  final ImagePicker imagePicker = ImagePicker();
  final _store = FirebaseStorage.instance;
  String path = '';
  int id = 10;

  @override
  void initState() {
    startCamera();
    super.initState();
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImagePage(image: picture)));

                },
                child: button(Icon(Icons.camera), Alignment.bottomCenter)),
          ],
        ),
      );
    } else {
      return SizedBox();
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
        boxShadow: [
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
