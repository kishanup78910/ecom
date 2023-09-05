// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'shoes',
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
            children: List.generate(shoessCat.length, (index) {
              return Column(
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
              );
            }),
          ),
        )
      ],
    );
  }
}
