import 'package:flutter/material.dart';

import '../../camera_page/camera_page.dart';

class ModeOptionView extends StatelessWidget {
  const ModeOptionView({Key? key, required this.title, required this.imageName})
      : super(key: key);
  final String title;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تصویر از $title',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text('گرفتن تصویر از سمت $title\n وآنالیز کردن آن.'),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(imageName, height: 120),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
