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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          '$subCatName',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(child: Text(mainCateName)),
    );
  }
}
