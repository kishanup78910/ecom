import 'package:ecom/DashBoradComponents/deliveredOrder.dart';
import 'package:ecom/DashBoradComponents/preparingOrder.dart';
import 'package:ecom/DashBoradComponents/shippingOrder.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class SupplierOrder extends StatelessWidget {
  const SupplierOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Supplier Order'),
          leading: const AppBarBackButton(),
          bottom: const TabBar(tabs: [
            RepeatedTab(label: 'Preparing'),
            RepeatedTab(label: 'Shipping'),
            RepeatedTab(label: 'Delivered'),
          ]),
        ),
        body: TabBarView(children: [Preparing(), Shipping(), Delivered()]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Center(
            child: Text(
      label,
      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    )));
  }
}
