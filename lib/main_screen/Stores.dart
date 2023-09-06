// ignore: file_names
// ignore: file_names
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Stores'),
      ),
    );
  }
}
