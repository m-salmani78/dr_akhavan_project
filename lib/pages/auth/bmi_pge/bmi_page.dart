import 'package:doctor_akhavan_project/pages/auth/body_size/body_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../helpers/show_snack_bar.dart';
import '../../../models/patient.dart';

const titleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

class BMIPage extends StatefulWidget {
  final Patient patient;
  const BMIPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  String _height = '';
  String _weight = '';
  int? _activityLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشخصات کاربر'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
            title: 'قد',
            suffixText: 'cm',
            onChanged: (value) => _height = value,
          ),
          const SizedBox(height: 24),
          _buildTextField(
            title: 'وزن',
            suffixText: 'kg',
            onChanged: (value) => _weight = value,
          ),
          const SizedBox(height: 24),
          _buildActivityLevel(),
          // const SizedBox(height: 48),
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  _buildTextField(
      {required String title,
      ValueChanged<String>? onChanged,
      String? suffixText}) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: titleTextStyle),
        ),
        Flexible(
          // flex: 2,
          child: TextField(
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            // keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              prefixText: suffixText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('میزان فعالیت', style: titleTextStyle),
        _buildRadio(value: 0, title: 'میزان متابولیسم پایه (BMR)'),
        _buildRadio(value: 1, title: 'کم یا بدون ورزش'),
        _buildRadio(value: 2, title: '1 - 3 بار ورزش در هفته'),
        _buildRadio(value: 3, title: '4 - 5 بار ورزش در هفته'),
        _buildRadio(
            value: 4,
            title: 'ورزش بصورت روزانه یا 3 - 4 بار ورزش سنگین در هفته'),
        _buildRadio(value: 5, title: '6 - 7 بار ورزش سنگین در هفته'),
        _buildRadio(value: 6, title: 'کار یا ورزش خیلی سنگین روزانه'),
      ],
    );
  }

  Widget _buildRadio({required int value, required String title}) {
    return RadioListTile<int>(
      value: value,
      groupValue: _activityLevel,
      onChanged: (value) => setState(() => _activityLevel = value),
      title: Text(title),
    );
  }

  _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ElevatedButton.icon(
        onPressed: (_activityLevel != null &&
                _height.isNotEmpty &&
                _weight.isNotEmpty)
            ? () {
                widget.patient
                  ..height = int.tryParse(_height)
                  ..weight = int.tryParse(_weight)
                  ..activityLevel = _activityLevel;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BodySizePage(patient: widget.patient),
                  ),
                );
              }
            : () {
                showWarningSnackBar(context,
                    message: 'ابتدا اطلاعات خواسته شده را تکمیل کنید.');
              },
        label: const SizedBox(
          width: double.infinity,
          child: Text('بعدی', textAlign: TextAlign.center),
        ),
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }
}
