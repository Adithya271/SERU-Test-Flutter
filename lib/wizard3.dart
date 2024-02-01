import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:provider/provider.dart';

import 'wizard1.dart';

class MyWizard3 extends StatefulWidget {
  const MyWizard3({super.key});

  @override
  _Wizard3State createState() => _Wizard3State();
}

class _Wizard3State extends State<MyWizard3> {
  String ktpNumber = '';

  Future<void> processKTPImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final result = await FlutterTesseractOcr.extractText(
        pickedImage.path,
        language: 'eng',
      );

      setState(() {
        ktpNumber = result.trim();

        WizardData wizardData = Provider.of<WizardData>(context, listen: false);
        wizardData.updateKTPNumber(ktpNumber);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WizardData wizardData = WizardData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wizard 3'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Data JSON untuk dikirim ke API:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '{',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            buildJsonField('firstName', wizardData.firstName),
            buildJsonField('lastName', wizardData.lastName),
            buildJsonField('biodata', wizardData.biodata),
            buildJsonField('provinsi', wizardData.selectedProvinsi),
            buildJsonField('kecamatan', wizardData.selectedKecamatan),
            buildJsonField('kelurahan', wizardData.selectedKelurahan),
            buildJsonField('hubunganTertanggung', wizardData.hubungan),
            buildJsonField('tanggalWaktuKejadian', '2024-02-01 12:00:00'),
            buildJsonField('penyebabKejadian', wizardData.penyebabKejadian),
            buildJsonField('ktpNumber', wizardData.ktpNumber),
            const Text(
              '}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                processKTPImage();
              },
              child: const Text('Pilih Foto KTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildJsonField(String key, String value) {
    return Text(
      '"$key": "$value",',
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
  }
}
