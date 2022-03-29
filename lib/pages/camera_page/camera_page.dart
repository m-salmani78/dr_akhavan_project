import 'package:doctor_akhavan_project/services/camera_service.dart';
import 'package:flutter/material.dart';

import '../../helpers/mixin.dart';
import 'widgets/body.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetHelper {
  final CameraService _service = CameraService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: buildComment(context,
              text:
                  'برای محاسبه درست ابعاد تصویر\nآن را در فاصله 30cm از دوربین قرار دهید')),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _service.init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error Accured'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Body(cameraService: _service);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
