// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> womensCat = [
  'images/women/women0.jpg',
  'images/women/women1.jpg',
  'images/women/women2.jpg',
  'images/women/women3.jpg',
  'images/women/women4.jpg',
  'images/women/women5.jpg',
  'images/women/women6.jpg',
  'images/women/women7.jpg',
  'images/women/women8.jpg',
  'images/women/women9.jpg',
];

List<String> womenLabel = [
  'dress',
  '2pcs sets',
  't-shirt',
  'top',
  'skirt',
  'jeans',
  'pants',
  'coat',
  'jacket',
  'other'
];

class WowomentCategory extends StatelessWidget {
  const WowomentCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                    'Women',
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
                    children: List.generate(womensCat.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategory(
                                        subCatName: womenLabel[index],
                                        mainCateName: 'Women',
                                      )));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              child: Image(
                                image: AssetImage(womensCat[index]),
                              ),
                              height: 70,
                              width: 70,
                            ),
                            Text(womenLabel[index])
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
                            " Women ",
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
      ],
    );
  }
}
