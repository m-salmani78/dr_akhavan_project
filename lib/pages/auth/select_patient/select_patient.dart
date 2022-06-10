import 'dart:developer';

import 'package:doctor_akhavan_project/services/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../constants/app_constants.dart';
import '../../../models/patient.dart';
import '../../home_page/home_page.dart';

class SelectPatientPage extends StatelessWidget {
  const SelectPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Patient>(patientBox);
    final List<Patient> patients = box.values.toList();
    log('${box.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب کاربر'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) =>
            _buildItem(context, patient: patients[index], index: index),
      ),
    );
  }

  Widget _buildItem(BuildContext context,
      {required Patient patient, required int index}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadius * 4),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () {
          PatientAccount().accountIndex = index;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        },
        trailing: Icon(
          patient.gender == Gender.female ? Icons.female : Icons.male,
        ),
        title: Text(patient.name),
        subtitle: Text('سن: ${patient.age}'),
      ),
    );
  }
}
