import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/pages/distance_finder_page/distance_finder_page.dart';
import 'package:doctor_akhavan_project/services/draw_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/body.dart';

class ImagePage extends StatelessWidget with WidgetHelper {
  final XFile image;
  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawImageProvider(image),
      builder: (context, child) {
        final provider = context.watch<DrawImageProvider>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: customAppBar(
            title: buildComment(
              context,
              text: 'پنج نقطه در تصویر انتخاب کنید',
            ),
          ),
          body: const Align(alignment: Alignment.bottomCenter, child: Body()),
          floatingActionButton: provider.points.length >= maxPointsNum
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DistanceFinderPage(
                          image: image,
                          points: provider.points,
                        ),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  child: const Icon(Icons.done),
                )
              : null,
        );
      },
    );
  }
}
