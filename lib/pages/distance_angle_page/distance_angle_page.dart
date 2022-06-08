import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/helpers/show_snack_bar.dart';
import 'package:doctor_akhavan_project/helpers/side_mode.dart';
import 'package:doctor_akhavan_project/models/case.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'widget/body.dart';

class DistanceAnglePage extends StatefulWidget {
  final Case sideCase;
  final XFile? image;
  final String imagePath;
  const DistanceAnglePage({
    Key? key,
    required this.sideCase,
    this.image,
    this.imagePath = '',
  }) : super(key: key);

  @override
  State<DistanceAnglePage> createState() => _DistanceAnglePageState();
}

class _DistanceAnglePageState extends State<DistanceAnglePage>
    with WidgetHelper {
  late Box<Patient> box;
  final _customTextStyle = const TextStyle(color: Colors.black87, fontSize: 16);
  bool _isDistanceMode = true;

  @override
  void initState() {
    box = Hive.box<Patient>(patientBox);
    super.initState();
  }

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
            setState(() => _isDistanceMode = value == 1);
          },
        ),
        actions: [
          if (widget.image != null)
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => _buildDialog(),
                );
              },
              tooltip: 'ذخیره',
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Body(
            image: Image.file(
              File(
                  widget.image != null ? widget.image!.path : widget.imagePath),
            ),
            sideCase: widget.sideCase,
            isDistanceMode: _isDistanceMode),
      ),
    );
  }

  Widget _buildDialog() {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('آیا میخواهید تصویر را ذخیره کنید؟'),
      actions: [
        TextButton(
          child: const Text('خیر'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          onPressed: () async {
            try {
              String? dir;
              if (Platform.isAndroid) {
                dir = (await getExternalStorageDirectory())?.path;
              } else if (Platform.isIOS) {
                dir = (await getApplicationDocumentsDirectory()).path;
              }
              if (dir == null) throw Exception();
              final Patient patient = box.getAt(0)!;
              switch (widget.sideCase.sideMode) {
                case SideMode.front:
                  patient.frontSideCase = widget.sideCase;
                  break;
                case SideMode.back:
                  patient.backSideCase = widget.sideCase;
                  break;
                case SideMode.right:
                  patient.rightSideCase = widget.sideCase;
                  break;
              }
              await widget.image!.saveTo(dir + widget.sideCase.imageName);
              await patient.saveToFile(dir);
              await box.clear();
              await box.add(patient);
              showSuccessSnackBar(context,
                  message: 'عملیات با موفقیت انجام شد.');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            } catch (e) {
              log(e.toString());
              showWarningSnackBar(context,
                  message: 'ذخیره سازی با مشکل مواجه شد.');
            }
          },
          child: const Text('بله'),
        ),
      ],
    );
  }
}
