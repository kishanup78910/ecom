import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/main_screen/Dashboard.dart';
import 'package:ecom/main_screen/Stores.dart';
import 'package:ecom/main_screen/category.dart';
import 'package:ecom/main_screen/home.dart';
import 'package:ecom/main_screen/upload_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const DashBoardScreen(),
    const UploadProducts()
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('deliveryStatus', isEqualTo: 'preparing')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              'This category has \n \n no items yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Acme',
                  letterSpacing: 1.5),
            ));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            body: _tabs[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Stores',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          );
        });
  }
}
