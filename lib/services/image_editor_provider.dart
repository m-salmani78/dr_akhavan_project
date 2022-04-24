import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart';

class ImageEditorProvider extends ChangeNotifier {
  File imageFile;

  ImageEditorProvider(XFile image) : imageFile = File(image.path);

  Future<void> clipImage({required num width, required num height}) async =>
      await handleOption(ClipOption(width: width, height: height));

  Future<void> rotateRight() async => await handleOption(RotateOption(90));

  Future<void> rotateLeft() async => await handleOption(RotateOption(-90));

  Future<void> flipHorizontally() async =>
      await handleOption(FlipOption(horizontal: true, vertical: false));

  Future<void> flipVertically() async =>
      await handleOption(FlipOption(horizontal: false, vertical: true));

  Future<void> handleOption(Option option) async {
    final ImageEditorOption editorOption = ImageEditorOption();
    editorOption.addOption(option);
    editorOption.outputFormat = const OutputFormat.png();
    final newFile = await ImageEditor.editFileImageAndGetFile(
        file: imageFile, imageEditorOption: editorOption);
    if (newFile != null) imageFile = newFile;
    log('edit done = ${newFile?.path ?? "null"}');
    notifyListeners();
  }
}
