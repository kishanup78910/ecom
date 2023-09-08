// ignore: file_names
import 'package:ecom/DashBoradComponents/EditBusiness.dart';
import 'package:ecom/DashBoradComponents/MyStore.dart';
import 'package:ecom/DashBoradComponents/manageProducts.dart';
import 'package:ecom/DashBoradComponents/supplierStatistc.dart';
import 'package:ecom/DashBoradComponents/supplier_balance.dart';
import 'package:ecom/DashBoradComponents/supplier_order.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

List<String> label = [
  'My store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statistics'
];

List<Widget> pages = [
  const MyStore(),
  const SupplierOrder(),
  const EditBusiness(),
  const ManageProducts(),
  const SupplierBlance(),
  const SupplierStatics()
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart
];

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppBarTitle(title: "Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]),
                );
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icons[index],
                        size: 50,
                        color: Colors.yellowAccent,
                      ),
                      Text(
                        label[index].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            fontFamily: 'Acme'),
                      )
                    ]),
              ),
            );
          }),
        ),
      ),
    );
  }
}
