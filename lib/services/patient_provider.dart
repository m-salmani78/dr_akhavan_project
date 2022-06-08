import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

class PatientProvider extends ChangeNotifier {
  final box = Hive.box<Patient>(patientBox);

  addPatient(BuildContext context, {required Patient patient}) {}
}
