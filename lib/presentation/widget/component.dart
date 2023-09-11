import 'package:flutter/material.dart';
import 'package:tigasendok/common/pallets.dart';
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

TextField customTextField({
  customTextFieldEnabled = true,
  required customTextFieldController,
  customTextFieldMaxLines,
  customTextFieldObscureText,
  customTextFieldKeyboardType,
  customTextFildOnChanged,
  customTextFieldErrorText,
  customTextFieldHintText,
  customTextFieldSuffix,
}) {
  return TextField(
    enabled: customTextFieldEnabled,
    controller: customTextFieldController,
    maxLines: customTextFieldMaxLines ?? 1,
    obscureText: customTextFieldObscureText ?? false,
    keyboardType: customTextFieldKeyboardType ?? TextInputType.text,
    onChanged: customTextFildOnChanged,
    decoration: InputDecoration(
      errorText: customTextFieldErrorText,
      errorStyle: bodyText2.copyWith(
        color: Colors.red,
      ),
      hintText: customTextFieldHintText ?? 'Please input text',
      hintStyle: bodyText2.copyWith(color: Colors.black.withOpacity(.5)),
      suffixIcon: customTextFieldSuffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(.5),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(.5),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor100,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    ),
  );
}

InkWell customButton(
  BuildContext context, {
  required customButtonTap,
  required customButtonValue,
  customButtonColor,
  customButtonWidth,
  customButtonHeight,
  customButtonValueColor,
}) {
  return InkWell(
    onTap: customButtonTap,
    child: Container(
      width: customButtonWidth ?? MediaQuery.of(context).size.width,
      height: customButtonHeight ?? 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: customButtonColor ?? primaryColor100,
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: customText(
          customTextValue: customButtonValue ?? 'Add Text',
          customTextStyle: subHeading2.copyWith(
            color: customButtonValueColor ?? secondaryColor100,
          ),
        ),
      ),
    ),
  );
}

InkWell customButtonWithIcon(
  BuildContext context, {
  required customButtonTap,
  required customButtonValue,
  required customButtonIcon,
  customButtonColor,
  customButtonWidth,
  customButtonValueColor,
  customButtonIconColor,
}) {
  return InkWell(
    onTap: customButtonTap,
    child: Container(
      width: customButtonWidth ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: customButtonColor ?? primaryColor100,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            customButtonIcon,
            color: customButtonIconColor ?? secondaryColor100,
            size: 16,
          ),
          customSpaceHorizontal(8),
          customText(
            customTextValue: customButtonValue ?? 'Add Text',
            customTextStyle: subHeading2.copyWith(
              color: customButtonValueColor ?? secondaryColor100,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding customVerticalDivider(
  BuildContext context, {
  required double customHeight,
  required customValue,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: customHeight),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        customText(
          customTextValue: customValue ?? 'Put Text Here',
          customTextStyle: bodyText1.copyWith(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ],
    ),
  );
}

AppBar customBasicAppBar(
  BuildContext context, {
  required customTitle,
  customAddAction,
  customLeading,
  isAction = true,
}) {
  return AppBar(
    backgroundColor: primaryColor100,
    elevation: 0,
    centerTitle: true,
    title: customText(
      customTextValue: customTitle,
      customTextStyle: heading4.copyWith(color: Colors.white),
    ),
    leading: IconButton(
      onPressed: customLeading ?? () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_rounded),
    ),
    actions: isAction
        ? [
            IconButton(
              onPressed: customAddAction,
              icon: const Icon(Icons.add_rounded),
            ),
          ]
        : [],
  );
}
