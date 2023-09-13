// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/utils/formatter.dart';
import 'package:tigasendok/presentation/screen/manage/manage_order_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageEditOrderScreen extends StatefulWidget {
  const ManageEditOrderScreen(
      {super.key, required this.accessToken, required this.id});
  static const routeName = '/manager-edit-order-screen';
  final String accessToken;
  final int id;

  @override
  State<ManageEditOrderScreen> createState() => _ManageEditOrderScreenState();
}

class _ManageEditOrderScreenState extends State<ManageEditOrderScreen> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final tempProduct = <Map<String, dynamic>>[];
  final tempCustomer = <Map<String, dynamic>>[];

  String? selectedProductValue;
  String? selectedCustomerValue;
  String? quantityErrorText;
  String? tempPrice;
  String? tempTotal;
  String? initProductValue;
  String? initCustomerValue;
  String? initQuantityValue;
  String? initPriceValue;
  String? initTotalValue;

  @override
  void initState() {
    fecthData();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBasicAppBar(
        context,
        customTitle: 'Ubah Pesanan',
        customLeading: () {
          Navigator.pushReplacementNamed(
            context,
            ManageOrderScreen.routeName,
            arguments: {'accessToken': widget.accessToken},
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
              itemCount: editOrderLists.length,
              itemBuilder: (context, contentIndex) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    customTextValue: editOrderLists[contentIndex],
                    customTextStyle: heading5,
                  ),
                  contentIndex == 0 || contentIndex == 1
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.575,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: secondaryColor100,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButton(
                            underline: const SizedBox.shrink(),
                            hint: customText(
                              customTextValue: contentIndex == 1
                                  ? initProductValue ?? 'Pilih produk'
                                  : initCustomerValue ?? 'Pilih pelanggan',
                              customTextStyle: subHeading3,
                            ),
                            value: contentIndex == 1
                                ? selectedProductValue
                                : selectedCustomerValue,
                            onChanged: (value) {
                              setState(() {
                                if (contentIndex == 1) {
                                  setState(() {
                                    selectedProductValue = value;
                                    tempPrice = tempProduct
                                        .firstWhere((element) =>
                                            element['id'].toString() ==
                                            selectedProductValue)['price']
                                        .toString();
                                  });
                                } else {
                                  setState(() => selectedCustomerValue = value);
                                }
                              });
                            },
                            items: contentIndex == 1
                                ? tempProduct.map((product) {
                                    return DropdownMenuItem(
                                      value: product['id'].toString(),
                                      child: customText(
                                        customTextValue: product['name'],
                                        customTextStyle: subHeading3,
                                      ),
                                    );
                                  }).toList()
                                : tempCustomer.map((customer) {
                                    return DropdownMenuItem(
                                      value: customer['id'].toString(),
                                      child: customText(
                                        customTextValue: customer['name'],
                                        customTextStyle: subHeading3,
                                      ),
                                    );
                                  }).toList(),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.575,
                          child: customTextField(
                            customTextFieldKeyboardType: contentIndex == 3
                                ? TextInputType.number
                                : TextInputType.text,
                            customTextFieldEnabled:
                                contentIndex == 2 || contentIndex == 4
                                    ? false
                                    : tempPrice == null
                                        ? false
                                        : true,
                            customTextFieldController: contentIndex == 2
                                ? priceController
                                : contentIndex == 3
                                    ? quantityController
                                    : totalPriceController,
                            customTextFieldErrorText:
                                contentIndex == 3 ? quantityErrorText : null,
                            customTextFieldHintText: contentIndex == 2
                                ? tempPrice == null
                                    ? 'Rp $initPriceValue'
                                    : formattedCurency(tempPrice!)
                                : contentIndex == 3
                                    ? initQuantityValue
                                    : tempTotal == null
                                        ? 'Rp $initTotalValue'
                                        : formattedCurency(tempTotal!),
                            customTextFildOnChanged: (value) {
                              if (contentIndex == 3) {
                                setState(() {
                                  if (value.isEmpty) {
                                    setState(() => quantityErrorText =
                                        'Jumlah tidak boleh kosong');
                                  } else {
                                    setState(() {
                                      quantityErrorText = null;
                                      tempTotal = (int.parse(tempPrice!) *
                                              int.parse(value))
                                          .toString();
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: ListView.separated(
                separatorBuilder: (context, index) => customSpaceVertical(16),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, buttonIndex) => customButton(
                  context,
                  customButtonTap: () {
                    switch (buttonIndex) {
                      case 0:
                        customDialogWithButton(
                          context,
                          customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                          customDialogText: 'Apakah kamu yakin ingin membayar?',
                          customDialogLeftButtonTap: () => payOrder(),
                          customDialogRightButtonTap: () =>
                              Navigator.pop(context),
                        );
                        break;
                      case 1:
                        if (selectedCustomerValue == null ||
                            selectedProductValue == null ||
                            quantityController.text.isEmpty) {
                          Future.delayed(
                            const Duration(seconds: 3),
                            () => Navigator.pop(context),
                          );
                          setState(() =>
                              quantityErrorText = 'Jumlah tidak boleh kosong');
                          customBasicDialog(
                            context,
                            customDialogIcon:
                                'lib/asset/lottie/lottieFailed.json',
                            customDialogText: 'Data tidak boleh kosong',
                          );
                        } else {
                          setState(() {
                            quantityErrorText = null;
                            customDialogWithButton(
                              context,
                              customDialogIcon:
                                  'lib/asset/lottie/lottieAsk.json',
                              customDialogText:
                                  'Apakah kamu yakin ingin mengubah?',
                              customDialogLeftButtonTap: () => updateOrder(
                                productId: int.parse(selectedProductValue!),
                                customerId: int.parse(selectedCustomerValue!),
                                customerQuantity: quantityController.text,
                                price: tempPrice,
                              ),
                              customDialogRightButtonTap: () =>
                                  Navigator.pop(context),
                            );
                          });
                        }
                        break;
                      case 2:
                        customDialogWithButton(
                          context,
                          customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                          customDialogText:
                              'Apakah kamu yakin ingin menghapus?',
                          customDialogLeftButtonTap: () => deleteOrder(),
                          customDialogRightButtonTap: () =>
                              Navigator.pop(context),
                        );
                        break;
                    }
                  },
                  customButtonValue: buttonIndex == 0
                      ? 'Bayar'
                      : buttonIndex == 1
                          ? 'Ubah'
                          : 'Hapus',
                  customButtonColor: buttonIndex == 0
                      ? Colors.green.shade800
                      : buttonIndex == 1
                          ? primaryColor100
                          : Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fecthData() async {
    final orderResponse = await Repository()
        .getOrderById(accessToken: widget.accessToken, id: widget.id);
    final customerResponse =
        await Repository().getCustomers(accessToken: widget.accessToken);
    final productResponse =
        await Repository().getProducts(accessToken: widget.accessToken);

    setState(() {
      initCustomerValue = orderResponse.customer.name.toString();
      initProductValue = orderResponse.product.name.toString();
      initQuantityValue = orderResponse.qty.toString();
      initPriceValue = orderResponse.price.toString();
      initTotalValue = orderResponse.total.toString();

      for (var i = 0; i < customerResponse.customer.length; i++) {
        final customer = customerResponse.customer[i];
        final customerObject = {
          'id': customer.id,
          'name': customer.name,
        };
        tempCustomer.add(customerObject);
      }

      for (var i = 0; i < productResponse.product.length; i++) {
        final product = productResponse.product[i];
        final productObject = {
          'id': product.id,
          'name': product.name,
          'price': product.price,
        };
        tempProduct.add(productObject);
      }
    });
  }

  updateOrder({
    required customerId,
    required productId,
    required customerQuantity,
    required price,
  }) async {
    final response = await Repository().updateOrderById(
      accessToken: widget.accessToken,
      id: widget.id,
      customerId: customerId,
      productId: productId,
      quantity: customerQuantity,
      price: price,
    );

    if (response.id == null) {
      Future.delayed(const Duration(seconds: 3), () => Navigator.pop(context));
      customBasicDialog(
        context,
        customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
        customDialogText: 'Data gagal diubah',
      );
      return;
    }

    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, ManageOrderScreen.routeName,
          arguments: {'accessToken': widget.accessToken}),
    );
    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
      customDialogText: 'Data berhasil diubah',
    );
  }

  deleteOrder() async {
    await Repository()
        .deleteOrder(accessToken: widget.accessToken, id: widget.id);

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

  payOrder() async {
    final response = await Repository().payOrderById(
      accessToken: widget.accessToken,
      id: widget.id,
    );

    if (response.id == null) {
      Future.delayed(const Duration(seconds: 3), () => Navigator.pop(context));
      customBasicDialog(
        context,
        customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
        customDialogText: 'Data gagal dibayar',
      );
      return;
    }

    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, ManageOrderScreen.routeName,
          arguments: {'accessToken': widget.accessToken}),
    );
    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
      customDialogText: 'Data berhasil dibayar',
    );
  }
}
