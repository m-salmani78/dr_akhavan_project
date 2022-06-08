import 'dart:io';

import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'widget/body.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Patient>(patientBox);
    Patient? patients;
    try {
      patients = box.getAt(0);
    } catch (_) {}

    return Scaffold(
      appBar: AppBar(title: const Text('نتایج'), centerTitle: true),
      body: FutureBuilder(
        future: getDirection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String dir = snapshot.data as String;
            final list = [
              patients?.frontSideCase,
              patients?.backSideCase,
              patients?.rightSideCase
            ];
            return Body(dir: dir, list: list);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<String> getDirection() async {
    String? dir;
    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())?.path;
    } else if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    return dir!;
  }
}
