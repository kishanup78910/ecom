// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
import 'package:flutter/material.dart';

List<String> MensCat = [
  'images/men/men0.jpg',
  'images/men/men1.jpg',
  'images/men/men2.jpg',
  'images/men/men3.jpg',
  'images/men/men4.jpg',
  'images/men/men5.jpg',
  'images/men/men6.jpg',
  'images/men/men7.jpg',
];

List<String> menLable = [
  'shirt',
  't-shirt',
  'jacket',
  'vest',
  'coat',
  'jeans',
  'shorts',
  'suit',
  'other',
];

class MenCategory extends StatelessWidget {
  const MenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'Men',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: GridView.count(
            mainAxisSpacing: 70,
            crossAxisSpacing: 15,
            crossAxisCount: 3,
            children: List.generate(MensCat.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubCategory(
                                subCatName: menLable[index],
                                mainCateName: 'men',
                              )));
                },
                child: Column(
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage(MensCat[index]),
                      ),
                      height: 70,
                      width: 70,
                    ),
                    Text(menLable[index])
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
