// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/presentation/widget/component.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({
    super.key,
    required this.category,
    required this.accessToken,
  });
  static const routeName = '/manage-screen';
  final String category;
  final String accessToken;

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBasicAppBar(
        context,
        customTitle: widget.category == 'customer'
            ? 'Kelola Pelanggan'
            : 'Kelola Pesanan',
        customAddAction: () {},
      ),
      body: FutureBuilder(
        future: widget.category == 'customer'
            ? Repository().getCustomers(accessToken: widget.accessToken)
            : Repository().getCustomers(accessToken: widget.accessToken),
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
                      onTap: () => Navigator.pushNamed(
                        context,
                        popupMenuLists[index]['route'],
                        arguments: {
                          'accessToken': widget.accessToken,
                          'id': item.id
                        },
                      ),
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
}
