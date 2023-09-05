// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> beautysCat = [
  'images/beauty/beauty0.jpg',
  'images/beauty/beauty1.jpg',
  'images/beauty/beauty2.jpg',
  'images/beauty/beauty3.jpg',
  'images/beauty/beauty4.jpg',
  'images/beauty/beauty5.jpg',
];

List<String> beautyLabel = [
  'body care',
  'hair care',
  'men perfume',
  'women perfume',
  'make up',
  'other'
];

class beautyCategory extends StatelessWidget {
  const beautyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'beauty',
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
            children: List.generate(beautysCat.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage(beautysCat[index]),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  Text(beautyLabel[index])
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
