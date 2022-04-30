import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/pages/distance_angle_page/distance_angle_page.dart';
import 'package:doctor_akhavan_project/services/draw_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/body.dart';

class ImagePage extends StatelessWidget with WidgetHelper {
  final XFile image;
  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => DrawImageProvider(
        image: image,
        selectedPoint: Offset(size.width / 2, size.height / 2),
      ),
      builder: (context, child) {
        final provider = context.watch<DrawImageProvider>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: customAppBar(leading: const CloseButton()),
          body: const Align(alignment: Alignment.bottomCenter, child: Body()),
          bottomSheet: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
            child: Row(children: [
              provider.isFinished
                  ? _buildCustomButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => DistanceAnglePage(
                            provider: provider,
                          ),
                        ),
                        (route) => route.isFirst,
                      ),
                      title: 'تایید',
                    )
                  : _buildCustomButton(
                      onPressed: () => provider.setPoint(),
                      title: 'بعدی',
                    ),
              const Spacer(),
              if (!provider.isEmpty)
                _buildCustomButton(
                  onPressed: () => provider.undoSetPoint(),
                  title: 'قبلی',
                ),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildCustomButton({
    void Function()? onPressed,
    required String title,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
