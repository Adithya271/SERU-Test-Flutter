import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class MyWizard2 extends StatefulWidget {
  const MyWizard2({Key? key}) : super(key: key);

  @override
  _MyWizard2State createState() => _MyWizard2State();
}

class _MyWizard2State extends State<MyWizard2> {
  File? selfieImage;
  File? ktpImage;
  File? freeImage;

  Future<void> _uploadImage(String option) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        switch (option) {
          case 'Foto Selfie':
            selfieImage = File(pickedImage.path);
            break;
          case 'Foto KTP':
            ktpImage = File(pickedImage.path);
            break;
          case 'Foto Bebas':
            freeImage = File(pickedImage.path);
            break;
        }
      });
    }
  }

  Future<void> _previewOrReuploadImage(String option) async {
    File? selectedImage;
    switch (option) {
      case 'Foto Selfie':
        selectedImage = selfieImage;
        break;
      case 'Foto KTP':
        selectedImage = ktpImage;
        break;
      case 'Foto Bebas':
        selectedImage = freeImage;
        break;
    }

    if (selectedImage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Preview'),
            content: Image.file(selectedImage!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info'),
            content: const Text('Anda belum mengunggah gambar ini.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Klaim'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Formulir Klaim',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.file_copy,
                          size: 30.0,
                        ),
                        Text(
                          'Formulir Klaim',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Upload Foto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    buildUploadOption('Foto Selfie'),
                    const SizedBox(height: 8.0),
                    buildUploadOption('Foto KTP'),
                    const SizedBox(height: 8.0),
                    buildUploadOption('Foto Bebas'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadOption(String option) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(option),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _uploadImage(option);
              },
              child: const Text('Upload'),
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                _previewOrReuploadImage(option);
              },
              child: const Text('Preview'),
            ),
          ],
        ),
      ],
    );
  }
}
