import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../services/camera_service.dart';

class Body extends StatefulWidget {
  final CameraService cameraService;
  const Body({Key? key, required this.cameraService}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraPreview(widget.cameraService.controller),
        Column(
          children: [
            const Spacer(),
            const Divider(thickness: 1, color: Colors.white60),
            const SizedBox(),
            Row(
              children: [
                const Spacer(),
                OutlinedButton(
                  style: _customOutlinedButtonStyle(),
                  child: const Icon(Icons.cameraswitch),
                  onPressed: () {},
                ),
                const Spacer(),
                ElevatedButton(
                  style: _customElevatedButtonStyle(),
                  child: const Icon(Icons.circle_outlined, size: 32),
                  onPressed: () => widget.cameraService.takePicture(context),
                ),
                const Spacer(),
                OutlinedButton(
                  style: _customOutlinedButtonStyle(),
                  child: Icon(widget.cameraService.flashModeIcon),
                  onPressed: () =>
                      setState(() => widget.cameraService.switchCamera()),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ],
    );
  }

  ButtonStyle _customOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: const CircleBorder(),
        primary: Colors.white,
        backgroundColor: Colors.black12);
  }

  ButtonStyle _customElevatedButtonStyle() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      shape: const CircleBorder(),
      primary: Colors.white,
    );
  }
}
