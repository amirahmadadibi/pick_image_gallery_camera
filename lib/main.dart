import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    final XFile? selectedFileWarpedBytes = await picker.pickImage(source: ImageSource.gallery);


    //may no longer be valid when the selectImageFromGallery() method completes (due to navigation changes or widget disposal).
    // Ensure the widget is still mounted before using the context
    if (!mounted) return;

    if (selectedFileWarpedBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطایی در انتخاب فایل به‌وجود آمده است.'),
        ),
      );
      return;
    }

    setState(() {
      _imageFile = File(selectedFileWarpedBytes.path);
    });
  }

  void takePictureByCamera() async{

    final XFile? captueredImageFromCamera = await picker.pickImage(source: ImageSource.camera);

    if (!mounted) return;

    if (captueredImageFromCamera == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطایی در انتخاب فایل به‌وجود آمده است.'),
        ),
      );
      return;
    }

    setState(() {
      _imageFile = File(captueredImageFromCamera.path);
    });
  }

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
                child: const Text("انتخاب فایل "),
              ),
              ElevatedButton(
                onPressed: () {
                  takePictureByCamera();
                },
                child: const Text("گرفتن عکس با دوربین"),
              )
            ],
          )),
    );
  }
}
