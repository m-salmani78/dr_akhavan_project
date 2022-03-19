import 'package:flutter/material.dart';

import '../camera_page/camera_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      appBar: AppBar(title: const Text('فاصله یاب')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'توضیحات:',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Text(
              'کاربر گرامی، برای محاسبه درست فاصله نقاط در تصویر لطفا جسم را در 20 سانتی از دوربین قرار دهید. ',
              textDirection: TextDirection.rtl,
            ),
            const Spacer(),
            Container(
              constraints: BoxConstraints(minWidth: size, minHeight: size),
              child: OutlinedButton(
                  style: _customOutlinedButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.camera_alt_rounded, size: 48)),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  ButtonStyle _customOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
