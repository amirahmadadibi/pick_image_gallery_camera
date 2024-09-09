import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _imageFile;

  void selectImageFromGallery() {}

  void takePictureByCamera() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'انتخاب فایل از گالری',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : const Icon(
                Icons.add_a_photo_outlined,
                size: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  selectImageFromGallery();
                },
                onLongPress: () {
                  takePictureByCamera();
                },
                child: const Text("انتخاب فایل "),
              )
            ],
          )),
    );
  }
}
