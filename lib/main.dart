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

    if (selectedFileWarpedBytes != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطایی در انتخاب فایل به‌وجود آمده است.'),
        ),
      );
      return;
    }

    setState(() {
      _imageFile = File(selectedFileWarpedBytes!.path);
    });
  }

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
                  ? SizedBox(height: 400, width: 200, child: Image.file(_imageFile!))
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
