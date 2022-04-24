import 'package:flutter/material.dart';

mixin WidgetHelper {
  AppBar customAppBar({Widget? title, Widget? leading, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      title: title,
      actions: actions,
      leading: leading,
    );
  }

  Widget buildComment(BuildContext context,
      {required String text, EdgeInsetsGeometry? margin}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
    );
  }
}
