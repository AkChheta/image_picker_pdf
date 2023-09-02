import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  ImagePicker picker = ImagePicker();
  List<XFile> images = [];

  Future<void> pickMultipleImages() async {
    List<XFile> image = await picker.pickMultiImage();
    setState(() {
      images.addAll(image);
    });
  }

  Future<void> pickCameraImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    setState(() {
      images.add(image!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Image Picker"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => pickMultipleImages(),
                  child: const Text("Pick from Gallery"),
                ),
                ElevatedButton(
                  onPressed: () => pickCameraImage(ImageSource.camera),
                  child: const Text("Pick from Camera"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(images[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
