import 'dart:async';
import 'package:doctor_akhavan_project/configs/default_theme.dart';
import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:doctor_akhavan_project/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CaseAdapter());
  Hive.registerAdapter(PatientAdapter());
  final box = await Hive.openBox<Patient>(patientBox);
  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  final Box<Patient> box;
  const MyApp({Key? key, required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      supportedLocales: const [Locale('fa')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: defaultTheme(),
      home: box.values.isNotEmpty ? const HomePage() : const RegisterPage(),
    );
  }
}
