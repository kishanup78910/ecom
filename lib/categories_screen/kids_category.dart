// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

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
  'images/kids/kids13.jpg',
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

class kidsCategory extends StatelessWidget {
  const kidsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'kids',
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
            children: List.generate(kidssCat.length, (index) {
              return Column(
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
              );
            }),
          ),
        )
      ],
    );
  }
}
