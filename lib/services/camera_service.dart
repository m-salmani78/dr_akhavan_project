import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/side_mode.dart';
import 'package:doctor_akhavan_project/pages/image_editor_page/image_editor_page.dart';
import 'package:flutter/material.dart';

class CameraService {
  late SideMode _sideMode;
  late CameraController controller;
  List<CameraDescription>? cameras;
  FlashMode flashMode = FlashMode.off;

  Future<List<CameraDescription>?> init(SideMode sideMode) async {
    _sideMode = sideMode;
    cameras = await availableCameras();
    log('${cameras?.length}', name: 'camera len');
    log('$cameras', name: 'camera');
    if (cameras == null) throw Exception();
    controller = CameraController(
      cameras!.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
        orElse: () => cameras![0],
      ),
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller.setFlashMode(flashMode);
    await controller.initialize();
    return cameras;
  }

  Future<void> takePicture(BuildContext context) async {
    final image = await controller.takePicture();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImageEditorPage(image: image, sideMode: _sideMode),
      ),
    );
  }

  void switchCamera() {
    //todo
  }

  void changeFlashMode() {
    final newFlashModeIdex = (flashMode.index + 1) % 3;
    controller.setFlashMode(FlashMode.values[newFlashModeIdex]);
  }

  IconData get flashModeIcon {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      default:
        return Icons.flash_on;
    }
  }

  dispose() {
    controller.dispose();
  }
}
