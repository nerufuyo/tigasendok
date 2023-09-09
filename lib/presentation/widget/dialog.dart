import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/presentation/widget/component.dart';

Future<dynamic> customBasicDialog(
  BuildContext context, {
  required customDialogIcon,
  required customDialogText,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              customDialogIcon,
              width: 140,
              fit: BoxFit.cover,
            ),
            customSpaceVertical(16),
            customText(
              customTextValue: customDialogText,
              customTextStyle: heading4,
            ),
          ],
        ),
      ),
    ),
  );
}
