import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/presentation/screen/manage/manage_order_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';

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
                            value: contentIndex == 0
                                ? selectedProductValue
                                : selectedCustomerValue,
                            onChanged: (value) {
                              setState(() {
                                if (contentIndex == 0) {
                                  setState(() {
                                    selectedProductValue = value.toString();
                                    priceController.text = tempProduct
                                        .firstWhere((product) =>
                                            product['id'] == value)['price']
                                        .toString();
                                  });
                                } else {
                                  setState(() {
                                    selectedCustomerValue = value.toString();
                                  });
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
                                    : true,
                            customTextFieldController: contentIndex == 2
                                ? priceController
                                : contentIndex == 3
                                    ? quantityController
                                    : totalPriceController,
                            customTextFieldErrorText:
                                contentIndex == 3 ? quantityErrorText : null,
                            customTextFieldHintText: contentIndex == 2
                                ? priceController.text
                                : contentIndex == 3
                                    ? 'Masukkan jumlah'
                                    : 'Total Harga',
                          ),
                        ),
                ],
              ),
            ),
            customButton(
              context,
              customButtonTap: () {},
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
}
