import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

class subCategoryModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subcategLabel;
  const subCategoryModel({
    super.key,
    required this.mainCategName,
    required this.subCategName,
    required this.assetName,
    required this.subcategLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SubCategory(
              subCatName: subCategName,
              mainCateName: mainCategName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Image(image: AssetImage(assetName)),
          ),
          Text(
            subcategLabel,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}

class categoryHeaderLable extends StatelessWidget {
  final String headerLabel;

  const categoryHeaderLable({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}

class slideBarwidget extends StatelessWidget {
  final String maincategName;
  const slideBarwidget({super.key, required this.maincategName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.05,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50)),
            child: const RotatedBox(
              quarterTurns: 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " << ",
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 18),
                    ),
                    Text(
                      " Men ",
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 18),
                    ),
                    Text(
                      " >> ",
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 18),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
