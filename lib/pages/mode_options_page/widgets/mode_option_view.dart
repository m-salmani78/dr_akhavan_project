import 'package:flutter/material.dart';

import '../../../helpers/side_mode.dart';
import '../../camera_page/camera_page.dart';

class ModeOptionView extends StatelessWidget {
  const ModeOptionView({Key? key, required this.sideMode}) : super(key: key);
  final SideMode sideMode;

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
              builder: (context) => CameraPage(sideMode: sideMode),
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
                    'تصویر از ${getSideModeName(sideMode)}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'گرفتن تصویر از سمت ${getSideModeName(sideMode)}\n وآنالیز کردن آن.'),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(getImageFromSideMode(sideMode), height: 120),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
