import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../register_page/register_page.dart';
import '../select_patient/select_patient.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ورود', style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(flex: 2),
            _buildButton(
              label: 'کاربر جدید',
              icon: Icons.group_add,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildButton(
              label: 'انتخاب کاربر',
              icon: Icons.group,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectPatientPage()),
                );
              },
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Card(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadius * 5),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        onTap: onTap,
        leading: Icon(icon),
        title: Text(label),
      ),
    );
  }
}
