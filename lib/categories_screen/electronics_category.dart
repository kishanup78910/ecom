// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> electronicssCat = [
  'images/electronics/electronics0.jpg',
  'images/electronics/electronics1.jpg',
  'images/electronics/electronics2.jpg',
  'images/electronics/electronics3.jpg',
  'images/electronics/electronics4.jpg',
  'images/electronics/electronics5.jpg',
  'images/electronics/electronics6.jpg',
  'images/electronics/electronics7.jpg',
  'images/electronics/electronics8.jpg',
  'images/electronics/electronics9.jpg',
  'images/electronics/electronics10.jpg',
  'images/electronics/electronics11.jpg',
  'images/electronics/electronics12.jpg',
  'images/electronics/electronics13.jpg',
];

List<String> electronicsLabel = [
  'phone',
  'computer',
  'laptop',
  'smart tv',
  'phone holder',
  'charger',
  'usb cables',
  'head phone',
  'smart watch',
  'tablet',
  'mouse',
  'keyboard',
  'gaming',
  'other'
];

// ignore: camel_case_types
class electronicsCategory extends StatelessWidget {
  const electronicsCategory({super.key});

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
                  'electronics',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: GridView.count(
                  mainAxisSpacing: 70,
                  crossAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: List.generate(electronicssCat.length - 1, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategory(
                                      subCatName: electronicsLabel[index + 1],
                                      mainCateName: 'Electonics',
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image(
                              image: AssetImage(electronicssCat[index + 1]),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Text(electronicsLabel[index + 1])
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
                          " Electronics ",
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
