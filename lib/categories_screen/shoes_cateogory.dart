// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> shoessCat = [
  'images/shoes/shoes0.jpg',
  'images/shoes/shoes1.jpg',
  'images/shoes/shoes2.jpg',
  'images/shoes/shoes3.jpg',
  'images/shoes/shoes4.jpg',
  'images/shoes/shoes5.jpg',
  'images/shoes/shoes6.jpg',
  'images/shoes/shoes7.jpg',
  'images/shoes/shoes8.jpg',
  'images/shoes/shoes9.jpg',
  'images/shoes/shoes10.jpg',
  'images/shoes/shoes11.jpg',
  'images/shoes/shoes12.jpg',
  'images/shoes/shoes13.jpg',
];

List<String> shoesLabel = [
  'men slippers',
  'men classic',
  'men casual',
  'men boots',
  'men canvas',
  'men sport',
  'men snadals',
  'home slippers',
  'women slippers',
  'women boots',
  'women heels',
  'women sport',
  'women snadals',
  'other'
];

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({super.key});

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
                  'shoes',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: GridView.count(
                  mainAxisSpacing: 80,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: List.generate(shoessCat.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategory(
                                      subCatName: shoesLabel[index],
                                      mainCateName: 'Shoes',
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image(
                              image: AssetImage(shoessCat[index]),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Text(shoesLabel[index])
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
                          " Shoes ",
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
