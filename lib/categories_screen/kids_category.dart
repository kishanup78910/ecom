// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> kidssCat = [
  'images/kids/kids0.jpg',
  'images/kids/kids1.jpg',
  'images/kids/kids2.jpg',
  'images/kids/kids3.jpg',
  'images/kids/kids4.jpg',
  'images/kids/kids5.jpg',
  'images/kids/kids6.jpg',
  'images/kids/kids7.jpg',
  'images/kids/kids8.jpg',
  'images/kids/kids9.jpg',
  'images/kids/kids10.jpg',
  'images/kids/kids11.jpg',
  'images/kids/kids12.jpg',
];

List<String> kidsLabel = [
  'girls sets',
  'girls dress',
  'girls top',
  'girls pants',
  'jacket',
  'sweatshirts',
  'boys sets',
  'boys top',
  'boys pants',
  'home wear',
  'boys suits',
  'baby shoes',
  'other'
];

// ignore: camel_case_types
class kidsCategory extends StatelessWidget {
  const kidsCategory({super.key});

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
                  'kids',
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
                  children: List.generate(kidssCat.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategory(
                                      subCatName: kidsLabel[index],
                                      mainCateName: 'Kids',
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image(
                              image: AssetImage(kidssCat[index]),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Text(kidsLabel[index])
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
                          " Kids ",
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
