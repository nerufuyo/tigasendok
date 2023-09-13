import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tigasendok/common/pallets.dart';
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
              customTextAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> customDialogWithButton(
  BuildContext context, {
  required customDialogIcon,
  required customDialogText,
  required customDialogLeftButtonTap,
  required customDialogRightButtonTap,
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
              width: 120,
              fit: BoxFit.cover,
              repeat: false,
            ),
            customSpaceVertical(16),
            customText(
              customTextValue: customDialogText,
              customTextStyle: heading4,
              customTextAlign: TextAlign.center,
            ),
            customSpaceVertical(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => customButton(
                  context,
                  customButtonTap: index == 0
                      ? customDialogLeftButtonTap
                      : customDialogRightButtonTap,
                  customButtonValue: index == 0 ? 'Ya' : 'Tidak',
                  customButtonWidth: MediaQuery.of(context).size.width * 0.325,
                  customButtonColor: index == 0 ? primaryColor100 : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
