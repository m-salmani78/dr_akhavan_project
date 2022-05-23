import 'package:flutter/material.dart';

import 'widgets/body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پروفایل'), centerTitle: true),
      body: const Body(),
    );
  }
}
