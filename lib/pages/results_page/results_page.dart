import 'dart:io';

import 'package:doctor_akhavan_project/pages/distance_angle_page/distance_angle_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/case.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Case>('caseBox');
    final cases = box.values;

    return Scaffold(
      appBar: AppBar(title: const Text('نتایج'), centerTitle: true),
      body: ListView(
        children: cases
            .map<Widget>(
              (e) => ListTile(
                leading: AspectRatio(
                  aspectRatio: 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(File(e.imagePath), fit: BoxFit.cover),
                  ),
                ),
                title: Text(e.fileName),
                subtitle:
                    Text(e.dateTime.toIso8601String().split('T').join('\n')),
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
                                .getRange(e.points.length ~/ 2, e.points.length)
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
