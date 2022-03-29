import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/services/image_distance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/body.dart';

class DistanceFinderPage extends StatelessWidget with WidgetHelper {
  final List<Offset> points;
  final XFile image;
  DistanceFinderPage({Key? key, required this.points, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageDistanceProvider(points: points, image: image),
      builder: (context, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: customAppBar(
            title: buildComment(
              context,
              text: 'برای مشاهده فاصله هر نقطه تا سایر نقاط\nروی آن کلیک کنید.',
            ),
          ),
          body: const Align(alignment: Alignment.bottomCenter, child: Body()),
          // bottomNavigationBar: buildComment(
          //   context,
          //   text: 'برای مشاهده فاصله هر نقطه تا سایر نقاط\nروی آن کلیک کنید.',
          //   margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          // ),
        );
      },
    );
  }
}
