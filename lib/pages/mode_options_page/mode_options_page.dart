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
          ModeOptionView(
              title: 'روبرو', imageName: 'assets/images/front_side.png'),
          ModeOptionView(
              title: 'کنار', imageName: 'assets/images/left_side.png'),
          ModeOptionView(
              title: 'پشت', imageName: 'assets/images/back_side.png'),
        ],
      ),
    );
  }
}
