// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/utils/formatter.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/screen/manage/add/manage_add_order_screen.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_order_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key, required this.accessToken});
  static const routeName = '/manage-order-screen';
  final String accessToken;

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBasicAppBar(
        context,
        customTitle: 'Kelola Pesanan',
        customLeading: () => Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
          arguments: {
            'accessToken': widget.accessToken,
          },
        ),
        customAddAction: () => Navigator.pushNamed(
          context,
          ManageAddOrderScreen.routeName,
          arguments: {
            'accessToken': widget.accessToken,
          },
        ),
      ),
      body: FutureBuilder(
        future: Repository().getOrders(accessToken: widget.accessToken),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState)
            return const Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final data = snapshot.data;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            separatorBuilder: (context, index) => customSpaceVertical(8),
            itemCount: data!.order.length,
            itemBuilder: (context, index) {
              final item = data.order[index];
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
                    item.customer.name.substring(0, 1),
                    style: heading3.copyWith(color: secondaryColor50),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customText(
                        customTextValue: 'Order #${item.id}',
                        customTextStyle: subHeading2),
                    customText(
                        customTextValue: item.customer.name,
                        customTextStyle: heading5),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customText(
                      customTextValue: formattedDate(item.createdAt.toString()),
                      customTextStyle: subHeading3,
                    ),
                    customText(
                      customTextValue: formattedCurency(item.total.toString()),
                      customTextStyle: subHeading2.copyWith(
                        color: primaryColor100,
                      ),
                    ),
                  ],
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
                            ManageEditOrderScreen.routeName,
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
                            customDialogLeftButtonTap: () =>
                                deleteOrder(id: item.id),
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

  deleteOrder({required id}) async {
    await Repository().deleteOrder(accessToken: widget.accessToken, id: id);

    Future.delayed(
      const Duration(seconds: 0),
      () => Navigator.pushReplacementNamed(context, ManageOrderScreen.routeName,
          arguments: {'accessToken': widget.accessToken}),
    );
    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
      customDialogText: 'Data berhasil dihapus',
    );
  }
}
