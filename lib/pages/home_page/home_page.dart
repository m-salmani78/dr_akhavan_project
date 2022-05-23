import 'package:flutter/material.dart';

import '../mode_options_page/mode_options_page.dart';
import '../results_page/results_page.dart';
import '../settings_page/settings_page.dart';

const List<Widget> _slides = [
  ModeOptionsPage(),
  ResultsPage(),
  SettingsPage(),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _slides[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'آنالیز',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'نتایج',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'پروفایل',
          )
        ],
      ),
    );
  }

  // ButtonStyle _customOutlinedButtonStyle() {
  //   return OutlinedButton.styleFrom(
  //     padding: const EdgeInsets.all(16),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //   );
  // }
}
