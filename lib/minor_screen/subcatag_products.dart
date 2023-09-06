import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatelessWidget {
  final String mainCateName;
  final String subCatName;
  const SubCategory(
      {super.key, required this.subCatName, required this.mainCateName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        centerTitle: true,
        title: AppBarTitle(title: subCatName),
      ),
      body: Center(child: Text(mainCateName)),
    );
  }
}
