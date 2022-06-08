import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:doctor_akhavan_project/models/patient.dart';
import 'package:doctor_akhavan_project/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _name = '';
  String _age = '';
  Gender? _gender;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 24),
        _buildNameTextField(),
        const SizedBox(height: 24),
        _buildAgeTextField(),
        const SizedBox(height: 24),
        // _buildPhoneTextField(),
        // const SizedBox(height: 24),
        _buildGenderOptions(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        _buildConfirmButton(),
        const SizedBox(height: 16),
      ],
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
  //   return const TextField(
  //     textInputAction: TextInputAction.next,
  //     decoration: InputDecoration(hintText: 'شماره تلفن'),
  //   );
  // }

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
    return SizedBox(
      width: double.infinity,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: (_gender != null && _name.isNotEmpty && _age.isNotEmpty)
            ? () {
                final int age = int.tryParse(_age) ?? 0;
                final patient = Patient.init(
                  name: _name,
                  age: age,
                  gender: _gender!,
                );
                final box = Hive.box<Patient>(patientBox);
                box.add(patient);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            : null,
        child: const Text('تایید'),
      ),
    );
  }
}
