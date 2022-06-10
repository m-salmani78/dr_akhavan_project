import 'dart:developer';

import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants/app_constants.dart';
import '../../../models/patient.dart';
import '../bmi_pge/bmi_page.dart';

class BodySizePage extends StatefulWidget {
  final Patient patient;
  const BodySizePage({Key? key, required this.patient}) : super(key: key);

  @override
  State<BodySizePage> createState() => _BodySizePageState();
}

class _BodySizePageState extends State<BodySizePage> {
  String _bustSize = '';
  String _waistSize = '';
  String _highHipSize = '';
  String _hipSize = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('مشخصات کاربر'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
              title: 'سایز سینه', onChanged: (value) => _bustSize = value),
          const SizedBox(height: 24),
          _buildTextField(
              title: 'سایز کمر', onChanged: (value) => _waistSize = value),
          const SizedBox(height: 24),
          _buildTextField(
              title: 'سایز بالای باسن',
              onChanged: (value) => _highHipSize = value),
          const SizedBox(height: 24),
          _buildTextField(
              title: 'سایز باسن', onChanged: (value) => _hipSize = value),
          const SizedBox(height: 48),
          Center(
            child: Image.asset(
              'assets/images/body_tags.jpeg',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  _buildTextField({required String title, ValueChanged<String>? onChanged}) {
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
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              prefixText: 'cm',
            ),
          ),
        ),
      ],
    );
  }

  _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ElevatedButton(
        onPressed: () async {
          widget.patient
            ..bustSize = int.tryParse(_bustSize)
            ..waistSize = int.tryParse(_waistSize)
            ..highHipSize = int.tryParse(_highHipSize)
            ..hipSize = int.tryParse(_hipSize);
          final box = Hive.box<Patient>(patientBox);
          await box.add(widget.patient);
          log('${box.length}');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        },
        child: const SizedBox(
          width: double.infinity,
          child: Text('تایید', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
