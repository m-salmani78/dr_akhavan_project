import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:doctor_akhavan_project/services/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'widget/body.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Patient>(patientBox);
    Patient? patient;
    try {
      patient = box.getAt(PatientAccount().accountIndex ?? 0);
    } catch (_) {}

    return Scaffold(
      appBar: AppBar(title: const Text('نتایج'), centerTitle: true),
      body: FutureBuilder(
        future: PatientAccount().getDirection(patient?.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String dir = snapshot.data as String;
            final list = [
              patient?.frontSideCase,
              patient?.backSideCase,
              patient?.rightSideCase
            ];
            return Body(dir: dir, list: list);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
