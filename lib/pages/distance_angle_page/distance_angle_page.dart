import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/helpers/show_snack_bar.dart';
import 'package:doctor_akhavan_project/models/case.dart';
import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/draw_image_provider.dart';
import 'widget/body.dart';

class DistanceAnglePage extends StatefulWidget {
  final DrawImageProvider provider;
  const DistanceAnglePage({Key? key, required this.provider}) : super(key: key);

  @override
  State<DistanceAnglePage> createState() => _DistanceAnglePageState();
}

class _DistanceAnglePageState extends State<DistanceAnglePage>
    with WidgetHelper {
  final _customTextStyle = const TextStyle(color: Colors.black87, fontSize: 16);
  bool _isDistanceMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: customAppBar(
          title: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: Colors.grey,
            groupValue: _isDistanceMode ? 1 : 0,
            children: {
              1: Text('ابعاد', style: _customTextStyle),
              0: Text('انحراف', style: _customTextStyle),
            },
            onValueChanged: (value) {
              if (value == null) return;
              setState(() {
                _isDistanceMode = value == 1;
              });
            },
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final String dateTime = DateTime.now().toIso8601String();
                final _case = Case(
                  caseId: 1,
                  patientId: 1,
                  imageName: '/image$dateTime.png',
                  sideMode: SideMode.front,
                  points: widget.provider.rightPoints.toList() +
                      widget.provider.leftPoints.toList(),
                );
                final result = await _case.saveToFile(widget.provider.image);
                if (result) {
                  showSuccessSnackBar(context,
                      message: 'عملیات با موفقیت انجام شد.');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                } else {
                  showWarningSnackBar(context,
                      message: 'ذخیره سازی با مشکل مواجه شد.');
                }
              },
              tooltip: 'ذخیره',
              icon: const Icon(Icons.save),
            )
          ]),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Body(provider: widget.provider, isDistanceMode: _isDistanceMode),
      ),
    );
  }
}
