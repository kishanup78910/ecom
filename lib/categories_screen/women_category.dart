// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'Women',
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
            children: List.generate(womensCat.length, (index) {
              return Column(
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
              );
            }),
          ),
        )
      ],
    );
  }
}
