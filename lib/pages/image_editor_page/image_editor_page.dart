import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/services/image_editor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/side_mode.dart';
import '../image_select_points/image_select_points_page.dart';

class ImageEditorPage extends StatelessWidget with WidgetHelper {
  final XFile image;
  final SideMode sideMode;
  ImageEditorPage({Key? key, required this.image, required this.sideMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageEditorProvider(image),
      builder: (context, child) {
        final provider = context.watch<ImageEditorProvider>();
        return Scaffold(
          appBar: customAppBar(
            leading: CloseButton(onPressed: () => Navigator.pop(context)),
            actions: [
              IconButton(
                  onPressed: () => provider.clipImage(height: 100, width: 100),
                  icon: const Icon(Icons.crop)),
              IconButton(
                  onPressed: () => provider.rotateLeft(),
                  icon: const Icon(Icons.rotate_left)),
              IconButton(
                  onPressed: () => provider.rotateRight(),
                  icon: const Icon(Icons.rotate_right)),
              IconButton(
                  onPressed: () => provider.flipHorizontally(),
                  icon: const Icon(Icons.flip)),
              // IconButton(
              //     onPressed: () => provider.flipVertically(),
              //     icon: const Icon(Icons.flip)),
            ],
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: Image.file(provider.imageFile),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImageSelectPointsPage(
                      image: XFile(provider.imageFile.path),
                      sideMode: sideMode,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.check)),
        );
      },
    );
  }
}
