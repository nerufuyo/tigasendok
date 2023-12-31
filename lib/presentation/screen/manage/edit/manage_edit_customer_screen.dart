// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/presentation/screen/manage/manage_customer_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageEditCustomerScreen extends StatefulWidget {
  const ManageEditCustomerScreen({
    super.key,
    required this.accessToken,
    required this.id,
  });
  static const routeName = '/manage-edit-screen';
  final String accessToken;
  final int id;

  @override
  State<ManageEditCustomerScreen> createState() =>
      _ManageEditCustomerScreenState();
}

class _ManageEditCustomerScreenState extends State<ManageEditCustomerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedGenderValue;

  @override
  void initState() {
    super.initState();
    fecthData();
  }

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
        customTitle: 'Edit Pelanggan',
        isAction: false,
      ),
      body: FutureBuilder(
        future: Repository().getCustomerById(
          id: widget.id,
          accessToken: widget.accessToken,
        ),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState)
            return const Center(
                child: CircularProgressIndicator(color: primaryColor100));

          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final data = snapshot.data;
          return Container(
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
                                ? data!.name.toString()
                                : data!.phone.toString(),
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
                                  onChanged: (value) => setState(
                                      () => selectedGenderValue = value),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => customSpaceVertical(8),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, buttonIndex) => customButton(
                    context,
                    customButtonTap: () {
                      if (buttonIndex == 0)
                        return customDialogWithButton(
                          context,
                          customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                          customDialogText: 'Apakah kamu yakin ingin mengubah?',
                          customDialogLeftButtonTap: () => updateCustomer(
                            id: widget.id,
                            accessToken: widget.accessToken,
                            name: nameController.text.isEmpty
                                ? data!.name
                                : nameController.text,
                            gender: selectedGenderValue,
                            phone: phoneController.text.isEmpty
                                ? data!.phone
                                : phoneController.text,
                          ),
                          customDialogRightButtonTap: () =>
                              Navigator.pop(context),
                        );

                      if (buttonIndex == 1)
                        return customDialogWithButton(
                          context,
                          customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                          customDialogText:
                              'Apakah kamu yakin ingin menghapus?',
                          customDialogLeftButtonTap: () => deleteCustomer(
                            id: widget.id,
                            accessToken: widget.accessToken,
                          ),
                          customDialogRightButtonTap: () =>
                              Navigator.pop(context),
                        );
                    },
                    customButtonValue: buttonIndex == 0 ? 'Simpan' : 'Hapus',
                    customButtonColor:
                        buttonIndex == 0 ? primaryColor100 : Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  fecthData() async {
    final response = await Repository().getCustomerById(
      id: widget.id,
      accessToken: widget.accessToken,
    );
    selectedGenderValue = response.gender;
  }

  updateCustomer({
    required id,
    required accessToken,
    required name,
    required gender,
    required phone,
  }) async {
    final response = await Repository().updateCustomerById(
      id: id,
      accessToken: accessToken,
      name: name,
      gender: gender,
      phone: phone,
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
              arguments: {'accessToken': widget.accessToken}),
        );
        customBasicDialog(
          context,
          customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
          customDialogText: 'Data berhasil diubah',
        );
        break;
    }
  }

  deleteCustomer({required id, required accessToken}) async {
    await Repository().deleteCustomerByID(id: id, accessToken: accessToken);

    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
          context, ManageCustomerScreen.routeName,
          arguments: {'accessToken': widget.accessToken}),
    );

    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
      customDialogText: 'Data berhasil dihapus',
    );
  }
}
