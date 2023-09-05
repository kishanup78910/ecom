// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> bagssCat = [
  'images/bags/bags0.jpg',
  'images/bags/bags1.jpg',
  'images/bags/bags2.jpg',
  'images/bags/bags3.jpg',
  'images/bags/bags4.jpg',
  'images/bags/bags5.jpg',
  'images/bags/bags6.jpg',
  'images/bags/bags7.jpg',
];

List<String> bagsLabel = [
  'wallet',
  'clutch',
  'chest bag',
  'back pack',
  'business bags',
  'laptop bags',
  'women bags',
  'other'
];

class bagsCategory extends StatelessWidget {
  const bagsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'bags',
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
            children: List.generate(bagssCat.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage(bagssCat[index]),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  Text(bagsLabel[index])
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
