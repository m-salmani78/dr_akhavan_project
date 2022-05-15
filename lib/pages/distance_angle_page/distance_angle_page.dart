import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/mixin.dart';
import 'package:doctor_akhavan_project/helpers/show_snack_bar.dart';
import 'package:doctor_akhavan_project/models/case.dart';
import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'widget/body.dart';

class DistanceAnglePage extends StatefulWidget {
  final List<Offset> leftPoints;
  final List<Offset> rightPoints;
  final XFile? image;
  final String imagePath;
  const DistanceAnglePage(
      {Key? key,
      required this.leftPoints,
      required this.rightPoints,
      this.image,
      this.imagePath = ''})
      : super(key: key);

  @override
  State<DistanceAnglePage> createState() => _DistanceAnglePageState();
}

class _DistanceAnglePageState extends State<DistanceAnglePage>
    with WidgetHelper {
  late Box<Case> box;
  final _formKey = GlobalKey<FormState>();
  final _customTextStyle = const TextStyle(color: Colors.black87, fontSize: 16);
  bool _isDistanceMode = true;
  String _fileName = '';

  @override
  void initState() {
    box = Hive.box('caseBox');
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
              setState(() {
                _isDistanceMode = value == 1;
              });
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
          ]),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Body(
            image: Image.file(
              File(
                  widget.image != null ? widget.image!.path : widget.imagePath),
            ),
            leftPoints: widget.leftPoints,
            rightPoints: widget.rightPoints,
            isDistanceMode: _isDistanceMode),
      ),
    );
  }

  Widget _buildDialog() {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('نام فایل را وارد کنید:'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          onChanged: (value) => _fileName = value,
          validator: (value) {
            if (value == null || value.isEmpty) return 'این فیلد اجباریست.';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('لغو'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          onPressed: () async {
            try {
              if (!_formKey.currentState!.validate()) return;
              String? dir;
              if (Platform.isAndroid) {
                dir = (await getExternalStorageDirectory())?.path;
              } else if (Platform.isIOS) {
                dir = (await getApplicationDocumentsDirectory()).path;
              }
              if (dir == null) throw Exception();
              final dateTime = DateTime.now();
              final _case = Case(
                caseId: box.values.length,
                patientId: 1,
                fileName: _fileName,
                imagePath: '$dir/image_$_fileName.png',
                dateTime: dateTime,
                sideMode: SideMode.front,
                points: widget.rightPoints + widget.leftPoints,
              );
              await box.add(_case);
              await widget.image!.saveTo(_case.imagePath);
              await _case.saveToFile(dir);
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
          child: const Text('تایید'),
        ),
      ],
    );
  }
}
