import 'package:flutter/material.dart';
import 'package:tigasendok/common/typography.dart';

Text customText({
  required customTextValue,
  customTextStyle,
  customTextAlign,
}) {
  return Text(
    customTextValue,
    style: customTextStyle ?? heading1,
    textAlign: customTextAlign ?? TextAlign.start,
  );
}

SizedBox customSpaceVertical(double height) => SizedBox(height: height);

SizedBox customSpaceHorizontal(double width) => SizedBox(width: width);
