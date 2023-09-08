import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class SupplierOrder extends StatelessWidget {
  const SupplierOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Supplier Order'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
