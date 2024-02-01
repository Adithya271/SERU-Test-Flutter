import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WizardData with ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String biodata = '';
  String selectedProvinsi = '';
  String selectedKecamatan = '';
  String selectedKelurahan = '';
  String hubungan = '';
  String penyebabKejadian = '';
  String ktpNumber = '';
  DateTime? selectedDate;

  void updateKTPNumber(String ktpNumber) {
    this.ktpNumber = ktpNumber;
    notifyListeners();
  }

  void saveData() {
    notifyListeners();
  }
}

class MyWizard1 extends StatelessWidget {
  const MyWizard1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WizardData>(
      create: (context) => WizardData(),
      child: Builder(
        builder: (context) {
          var wizardData = context.watch<WizardData>();

          return _MyWizard1();
        },
      ),
    );
  }
}

class _MyWizard1 extends StatefulWidget {
  @override
  _Wizard1State createState() => _Wizard1State();
}

class _Wizard1State extends State<_MyWizard1> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController biodataController = TextEditingController();
  TextEditingController hubunganController = TextEditingController();
  TextEditingController penyebabController = TextEditingController();

  late String selectedProvinsi;
  late String selectedKecamatan;
  late String selectedKelurahan;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    var wizardData = Provider.of<WizardData>(context, listen: false);

    selectedProvinsi = wizardData.selectedProvinsi.isNotEmpty
        ? wizardData.selectedProvinsi
        : 'Provinsi 1';

    selectedKecamatan = wizardData.selectedKecamatan.isNotEmpty
        ? wizardData.selectedKecamatan
        : 'Kecamatan 1';

    selectedKelurahan = wizardData.selectedKelurahan.isNotEmpty
        ? wizardData.selectedKelurahan
        : 'Kelurahan 1';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wizardData = Provider.of<WizardData>(context);

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
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registrasi Klaim :  B 1234 EFG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'No.Polisi    ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Formulir Klaim',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.file_copy,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Registrasi Klaim :  B 1234 EFG',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
                      'First Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your first name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Last Name ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your last name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Biodata',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: biodataController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Enter biodata',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Provinsi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedProvinsi,
                      onChanged: (String? value) {
                        print('Selected Provinsi: $value');
                        setState(() {
                          selectedProvinsi = value!;
                        });
                      },
                      items: [
                        'Provinsi 1',
                        'Provinsi 2',
                        'Provinsi 3',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('Select Provinsi'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Kecamatan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedKecamatan,
                      onChanged: (String? value) {
                        setState(() {
                          selectedKecamatan = value!;
                        });
                      },
                      items: [
                        'Kecamatan 1',
                        'Kecamatan 2',
                        'Kecamatan 3',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('Select Kecamatan'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Kelurahan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedKelurahan,
                      onChanged: (String? value) {
                        setState(() {
                          selectedKelurahan = value!;
                        });
                      },
                      items: [
                        'Kelurahan 1',
                        'Kelurahan 2',
                        'Kelurahan 3',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('Select Kelurahan'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Hubungan dengan Tertanggung',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: hubunganController,
                      onChanged: (value) {
                        wizardData.hubungan = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Silahkan isi hubungan dengan tertanggung',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Tanggal dan Waktu Kejadian',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    if (selectedDate != null)
                      Text(
                        'Selected Date: ${selectedDate!.toLocal()}',
                      ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Penyebab Kejadian',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: penyebabController,
                      onChanged: (value) {
                        wizardData.penyebabKejadian = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Silahkan isi penyebab kejadian',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        wizardData.saveData();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
