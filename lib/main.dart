import 'package:flutter/material.dart';
import 'package:imagepicker/image_picker.dart';
import 'package:imagepicker/pdf_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: ImagePickerPage());
  }
}
