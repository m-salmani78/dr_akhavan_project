import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../services/camera_service.dart';
import 'device_accelerometer_painter.dart';

class Body extends StatefulWidget {
  final CameraService cameraService;
  const Body({Key? key, required this.cameraService}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late StreamSubscription _streamSubscriptions;
  double dx = 0, dy = 0;
  bool _rightAngle = false;

  @override
  void initState() {
    _streamSubscriptions = accelerometerEvents.listen(
      (event) => setState(() {
        dx = event.x * (100 / 9.8);
        dy = event.y * (100 / 9.8);
        _rightAngle = dy >= 98 && dx.abs() <= 1.5;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: DeviceAccelerometerPainter(dx, dy, rightAngle: _rightAngle),
        child: Column(
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
                  onPressed: () => setState(() {
                    widget.cameraService.switchCamera();
                  }),
                ),
                const Spacer(),
                ElevatedButton(
                  style: _customElevatedButtonStyle(),
                  child: const Icon(
                    Icons.circle_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: _rightAngle
                      ? () => widget.cameraService.takePicture(context)
                      : null,
                ),
                const Spacer(),
                OutlinedButton(
                  style: _customOutlinedButtonStyle(),
                  child: Icon(widget.cameraService.flashModeIcon),
                  onPressed: () =>
                      setState(() => widget.cameraService.changeFlashMode()),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ));
  }

  @override
  void dispose() {
    _streamSubscriptions.cancel();
    super.dispose();
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
