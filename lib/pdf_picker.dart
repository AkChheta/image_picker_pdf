// ignore_for_file: avoid_unnecessary_containers, unused_field, unnecessary_string_interpolations, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPickerPage extends StatefulWidget {
  const PdfPickerPage({super.key});

  @override
  _PdfPickerPageState createState() => _PdfPickerPageState();
}

class _PdfPickerPageState extends State<PdfPickerPage> {
  List<String> _selectedFileNames = [];
  List<String> _selectedFilePaths = [];

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      List<PlatformFile> files = result.files;

      setState(() {
        _selectedFileNames = files.map((file) => file.name).toList();
        _selectedFilePaths = files.map((file) => file.path ?? '').toList();
      });
    } else {
      print('User canceled the picker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickPdf,
              child: const Text('Pick a PDF'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 2),
                itemCount: _selectedFilePaths.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                                pdfPath: _selectedFilePaths[index]),
                          ),
                        );
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 30,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/PDF.png",
                            fit: BoxFit.cover,
                          ),
                          Text("${_selectedFileNames[index]}"),
                        ],
                      ),
                    ),
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

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
