// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/presentation/screen/manage/manage_customer_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageAddCustomer extends StatefulWidget {
  const ManageAddCustomer({
    super.key,
    required this.accessToken,
  });
  static const routeName = '/manage-add-customer';
  final String accessToken;

  @override
  State<ManageAddCustomer> createState() => _ManageAddCustomerState();
}

class _ManageAddCustomerState extends State<ManageAddCustomer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedGenderValue = 'male';
  String? nameErrorText;
  String? phoneErrorText;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBasicAppBar(
        context,
        customTitle: 'Tambah Pelanggan',
        customLeading: () {
          Navigator.pushReplacementNamed(
            context,
            ManageCustomerScreen.routeName,
            arguments: {
              'accessToken': widget.accessToken,
            },
          );
        },
        isAction: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => customSpaceVertical(16),
              shrinkWrap: true,
              itemCount: editCustomerLists.length,
              itemBuilder: (context, contentIndex) => Row(
                crossAxisAlignment: contentIndex == 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    customTextValue: editCustomerLists[contentIndex],
                    customTextStyle: heading5,
                  ),
                  if (contentIndex == 0 || contentIndex == 2)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: customTextField(
                        customTextFieldController: contentIndex == 0
                            ? nameController
                            : phoneController,
                        customTextFieldHintText: contentIndex == 0
                            ? 'Masukkan nama'
                            : 'Masukkan nomor telepon',
                        customTextFieldErrorText:
                            contentIndex == 0 ? nameErrorText : phoneErrorText,
                      ),
                    ),
                  if (contentIndex == 1)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.575,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: genderLists.length,
                        itemBuilder: (context, genderIndex) {
                          return ListTile(
                            dense: true,
                            title: customText(
                              customTextValue: genderLists[genderIndex]
                                  ['title'],
                              customTextStyle: subHeading3,
                            ),
                            leading: Radio(
                              value: genderLists[genderIndex]['value'],
                              groupValue: selectedGenderValue,
                              onChanged: (value) =>
                                  setState(() => selectedGenderValue = value),
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
            customButton(
              context,
              customButtonTap: () {
                if (nameController.text.isEmpty) {
                  setState(() => nameErrorText = 'Nama tidak boleh kosong');
                } else if (phoneController.text.isEmpty) {
                  setState(() =>
                      phoneErrorText = 'Nomor telepon tidak boleh kosong');
                } else {
                  setState(() {
                    nameErrorText = null;
                    phoneErrorText = null;
                  });

                  customDialogWithButton(
                    context,
                    customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                    customDialogText: 'Apakah kamu yakin ingin mengubah?',
                    customDialogLeftButtonTap: () => createFunction(
                      name: nameController.text,
                      gender: selectedGenderValue,
                      phone: phoneController.text,
                    ),
                    customDialogRightButtonTap: () => Navigator.pop(context),
                  );
                }
              },
              customButtonValue: 'Tambah Pelanggan',
            ),
          ],
        ),
      ),
    );
  }

  createFunction({
    required name,
    required gender,
    required phone,
  }) async {
    final response = await Repository().createCustomer(
      name: name,
      gender: gender,
      phone: phone,
      accessToken: widget.accessToken,
    );

    switch (response.name.isEmpty) {
      case true:
        Future.delayed(
            const Duration(seconds: 3), () => Navigator.pop(context));
        customBasicDialog(
          context,
          customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
          customDialogText: 'Data gagal diubah',
        );
        break;
      default:
        Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(
              context, ManageCustomerScreen.routeName,
              arguments: {
                'accessToken': widget.accessToken,
              }),
        );
        customBasicDialog(
          context,
          customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
          customDialogText: 'Data berhasil diubah',
        );
        break;
    }
  }
}
