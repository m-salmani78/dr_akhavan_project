import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/show_snack_bar.dart';
import '../../../models/patient.dart';
import '../bmi_pge/bmi_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = '';
  String _age = '';
  Gender? _gender;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشخصات کاربر'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: height * 0.2),
          _buildNameTextField(),
          const SizedBox(height: 36),
          _buildAgeTextField(),
          const SizedBox(height: 36),
          _buildGenderOptions(context),
          // SizedBox(height: height * 0.2),
          // const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      onChanged: (value) => _name = value,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(hintText: 'نام'),
    );
  }

  _buildAgeTextField() {
    return TextField(
      onChanged: (value) => _age = value,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(hintText: 'سن'),
    );
  }

  // _buildPhoneTextField() {
  _buildGenderOptions(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RadioListTile<Gender>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.2),
            selected: _gender == Gender.female,
            title: const Text('زن'),
            value: Gender.female,
            groupValue: _gender,
            onChanged: (value) => setState(() => _gender = value),
          ),
        ),
        const SizedBox(width: 24),
        Flexible(
          child: RadioListTile<Gender>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.2),
            selected: _gender == Gender.male,
            title: const Text('مرد'),
            value: Gender.male,
            groupValue: _gender,
            onChanged: (value) => setState(() => _gender = value),
          ),
        ),
      ],
    );
  }

  _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ElevatedButton.icon(
        onPressed: (_gender != null && _name.isNotEmpty && _age.isNotEmpty)
            ? () {
                final int age = int.tryParse(_age) ?? 0;
                final patient = Patient.init(
                  name: _name,
                  age: age,
                  gender: _gender!,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMIPage(patient: patient),
                  ),
                );
              }
            : () {
                showWarningSnackBar(
                  context,
                  message: 'ابتدا اطلاعات خواسته شده را تکمیل کنید.',
                );
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
