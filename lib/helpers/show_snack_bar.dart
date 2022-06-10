import 'package:doctor_akhavan_project/constants/app_constants.dart';
import 'package:flutter/material.dart';

void showWarningSnackBar(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.warning_rounded, color: Colors.white),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            message,
            style: const TextStyle(fontFamily: 'IranianSans'),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.orange,
    behavior: SnackBarBehavior.floating,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius * 4),
    ),
    // action: SnackBarAction(
    //     label: 'Done', textColor: Colors.white, onPressed: () {}),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            message,
            style: const TextStyle(fontFamily: 'IranianSans'),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius * 4),
    ),
    // action: SnackBarAction(
    //     label: 'Done', textColor: Colors.white, onPressed: () {}),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
