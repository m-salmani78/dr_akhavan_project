import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/services/draw_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/body.dart';

class ImagePage extends StatelessWidget {
  final XFile image;
  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawImageProvider(image),
      builder: (context, child) {
        final provider = context.watch<DrawImageProvider>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: _buildComment(context),
          ),
          body: const Body(),
          floatingActionButton: provider.isCompleted
              ? FloatingActionButton(
                  onPressed: () {
                    //todo
                  },
                  child: const Icon(Icons.done),
                )
              : null,
        );
      },
    );
  }

  Widget _buildComment(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.black12),
      child: Text(
        'پنج نقطه در تصویر انتخاب کنید',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
