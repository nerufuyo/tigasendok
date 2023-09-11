import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
