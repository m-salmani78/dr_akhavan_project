import 'dart:io';

import 'package:flutter/material.dart';

import '../../../models/case.dart';
import '../../distance_angle_page/distance_angle_page.dart';

class Body extends StatelessWidget {
  final List<Case?> list;
  final String dir;

  const Body({Key? key, required this.list, required this.dir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list
          .map<Widget>(
            (e) => e == null
                ? const SizedBox()
                : ListTile(
                    leading: AspectRatio(
                      aspectRatio: 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File('$dir/${e.imageName}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(e.imageName.split('.')[0]),
                    subtitle: Text(
                        e.dateTime.toIso8601String().split('T').join('\n')),
                    trailing: Text(e.sideMode.name),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DistanceAnglePage(
                              sideCase: e,
                              imagePath: '$dir/${e.imageName}',
                            ),
                          ));
                    },
                  ),
          )
          .toList(),
    );
  }
}
