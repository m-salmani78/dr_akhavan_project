import 'package:doctor_akhavan_project/helpers/side_mode.dart';
import 'package:doctor_akhavan_project/pages/mode_options_page/widgets/mode_option_view.dart';
import 'package:flutter/material.dart';

class ModeOptionsPage extends StatelessWidget {
  const ModeOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('آنالیز'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          ModeOptionView(sideMode: SideMode.front),
          ModeOptionView(sideMode: SideMode.back),
          ModeOptionView(sideMode: SideMode.right),
        ],
      ),
    );
  }
}
