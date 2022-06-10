import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PatientAccount {
  // addPatient(BuildContext context, {required Patient patient}) {}
  static final PatientAccount _instance = PatientAccount._internal();
  PatientAccount._internal();
  factory PatientAccount() => _instance;
  int? accountIndex;
  Future<String> getDirection(String? name) async {
    String? dir;
    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())?.path;
    } else if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    // dir = dir! + '/DrAkhavan';
    if (name != null) {
      dir = (await Directory('$dir/$name').create(recursive: true)).path;
    }
    log('Path: $dir');
    return dir!;
  }
}
