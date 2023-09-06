// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> accessoriessCat = [
  'images/accessories/accessories0.jpg',
  'images/accessories/accessories1.jpg',
  'images/accessories/accessories2.jpg',
  'images/accessories/accessories3.jpg',
  'images/accessories/accessories4.jpg',
  'images/accessories/accessories5.jpg',
  'images/accessories/accessories6.jpg',
  'images/accessories/accessories7.jpg',
];

List<String> accessoriesLabel = [
  'hat',
  'men sunglass',
  'w sunglass',
  'classic watch',
  'gloves',
  'belt waist',
  'ring',
  'necklace',
  'scarf set',
  'anklet',
  'other'
];

// ignore: camel_case_types
class accessoriesCategory extends StatelessWidget {
  const accessoriesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: 0,
        left: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'accessories',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: GridView.count(
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: List.generate(accessoriessCat.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategory(
                                      subCatName: accessoriesLabel[index],
                                      mainCateName: 'Accessories',
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image(
                              image: AssetImage(accessoriessCat[index]),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Text(accessoriesLabel[index])
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: SizedBox(
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
                          " Accessories ",
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
            )),
      )
    ]);
  }
}
