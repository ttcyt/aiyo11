import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  ImagePage({super.key, required this.image});

  XFile image;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOW IMAGE'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.file(File(image.path)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await _store.ref('image/$id.png').putFile(File(image.path));
          // id++;
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
