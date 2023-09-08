import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class SupplierStatics extends StatelessWidget {
  const SupplierStatics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'SupplierStatics'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
