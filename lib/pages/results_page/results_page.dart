import 'dart:io';

import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:doctor_akhavan_project/pages/distance_angle_page/distance_angle_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
      body: ListView(
        children: [
          patients?.frontSideCase,
          patients?.backSideCase,
          patients?.rightSideCase
        ]
            .map<Widget>(
              (e) => e == null
                  ? const SizedBox()
                  : ListTile(
                      leading: AspectRatio(
                        aspectRatio: 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              Image.file(File(e.imagePath), fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(e.fileName),
                      subtitle: Text(
                          e.dateTime.toIso8601String().split('T').join('\n')),
                      trailing: Text(e.sideMode.name),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DistanceAnglePage(
                                  rightPoints: e.points
                                      .getRange(0, e.points.length ~/ 2)
                                      .toList(),
                                  leftPoints: e.points
                                      .getRange(
                                          e.points.length ~/ 2, e.points.length)
                                      .toList(),
                                  imagePath: e.imagePath),
                            ));
                      },
                    ),
            )
            .toList(),
      ),
    );
  }
}
