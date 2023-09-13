// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/utils/formatter.dart';
import 'package:tigasendok/presentation/screen/manage/manage_order_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class ManageAddOrderScreen extends StatefulWidget {
  const ManageAddOrderScreen({super.key, required this.accessToken});
  static const routeName = '/manage-add-order-screen';
  final String accessToken;

  @override
  State<ManageAddOrderScreen> createState() => _ManageAddOrderScreenState();
}

class _ManageAddOrderScreenState extends State<ManageAddOrderScreen> {
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
        customTitle: 'Tambah Pesanan',
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
                                  ? 'Pilih produk'
                                  : 'Pilih pelanggan',
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
                                    ? 'Masukkan harga'
                                    : formattedCurency(tempPrice!)
                                : contentIndex == 3
                                    ? 'Masukkan jumlah'
                                    : tempTotal == null
                                        ? 'Masukkan total'
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
            customButton(
              context,
              customButtonTap: () {
                if (quantityController.text.isEmpty) {}

                if (selectedCustomerValue == null ||
                    selectedProductValue == null ||
                    quantityController.text.isEmpty) {
                  Future.delayed(
                    const Duration(seconds: 3),
                    () => Navigator.pop(context),
                  );
                  setState(
                      () => quantityErrorText = 'Jumlah tidak boleh kosong');
                  customBasicDialog(
                    context,
                    customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
                    customDialogText: 'Data tidak boleh kosong',
                  );
                } else {
                  setState(() {
                    quantityErrorText = null;
                    customDialogWithButton(
                      context,
                      customDialogIcon: 'lib/asset/lottie/lottieAsk.json',
                      customDialogText: 'Apakah kamu yakin ingin mengubah?',
                      customDialogLeftButtonTap: () => createNewOrder(
                        productId: int.parse(selectedProductValue!),
                        customerId: int.parse(selectedCustomerValue!),
                        customerQuantity: quantityController.text,
                        price: tempPrice,
                      ),
                      customDialogRightButtonTap: () => Navigator.pop(context),
                    );
                  });
                }
              },
              customButtonValue: 'Tambah',
            ),
          ],
        ),
      ),
    );
  }

  fecthData() async {
    final customerResponse =
        await Repository().getCustomers(accessToken: widget.accessToken);
    final productResponse =
        await Repository().getProducts(accessToken: widget.accessToken);

    setState(() {
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

  createNewOrder({
    required customerId,
    required productId,
    required customerQuantity,
    required price,
  }) async {
    final response = await Repository().createOrder(
      accessToken: widget.accessToken,
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
        customDialogText: 'Data gagal ditambah',
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
      customDialogText: 'Data berhasil ditambah',
    );
  }
}
