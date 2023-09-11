// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/screen/manage/add/manage_add_customer.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_customer_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageCustomerScreen extends StatefulWidget {
  const ManageCustomerScreen({
    super.key,
    required this.accessToken,
  });
  static const routeName = '/manage-customer-screen';
  final String accessToken;

  @override
  State<ManageCustomerScreen> createState() => _ManageCustomerScreenState();
}

class _ManageCustomerScreenState extends State<ManageCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBasicAppBar(
        context,
        customTitle: 'Kelola Pelanggan',
        customLeading: () => Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
          arguments: {
            'accessToken': widget.accessToken,
          },
        ),
        customAddAction: () => Navigator.pushNamed(
          context,
          ManageAddCustomer.routeName,
          arguments: {
            'accessToken': widget.accessToken,
          },
        ),
      ),
      body: FutureBuilder(
        future: Repository().getCustomers(accessToken: widget.accessToken),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState)
            return const Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final data = snapshot.data;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            separatorBuilder: (context, index) => customSpaceVertical(8),
            itemCount: data!.customer.length,
            itemBuilder: (context, index) {
              final item = data.customer[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: secondaryColor100,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: CircleAvatar(
                  child: Text(
                    item.name.substring(0, 1).toUpperCase(),
                    style: heading3.copyWith(color: secondaryColor50),
                  ),
                ),
                title: customText(
                    customTextValue: item.name, customTextStyle: heading4),
                subtitle: customText(
                  customTextValue: item.phone,
                  customTextStyle: subHeading2,
                ),
                trailing: PopupMenuButton(
                  color: primaryColor100,
                  itemBuilder: (context) => List.generate(
                    popupMenuLists.length,
                    (index) => PopupMenuItem(
                      onTap: () {
                        if (popupMenuLists[index]['title'] == 'Edit') {
                          Navigator.pushNamed(
                            context,
                            ManageEditCustomerScreen.routeName,
                            arguments: {
                              'accessToken': widget.accessToken,
                              'id': item.id,
                            },
                          );
                        } else {
                          customDialogWithButton(
                            context,
                            customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                            customDialogText:
                                'Apakah kamu yakin ingin menghapus?',
                            customDialogLeftButtonTap: () => deleteCustomer(
                              id: item.id,
                              accessToken: widget.accessToken,
                            ),
                            customDialogRightButtonTap: () =>
                                Navigator.pop(context),
                          );
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            popupMenuLists[index]['icon'],
                            color: secondaryColor50,
                          ),
                          customSpaceHorizontal(12),
                          customText(
                            customTextValue: popupMenuLists[index]['title'],
                            customTextStyle: subHeading3.copyWith(
                              color: secondaryColor50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  deleteCustomer({required id, required accessToken}) async {
    await Repository().deleteCustomerByID(id: id, accessToken: accessToken);

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
      customDialogText: 'Data berhasil dihapus',
    );
  }
}
