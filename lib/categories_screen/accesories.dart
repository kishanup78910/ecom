// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> accessoriessCat = [
  'images/accessories/accessories0.jpg',
  'images/accessories/accessories1.jpg',
  'images/accessories/accessories2.jpg',
  'images/accessories/accessories3.jpg',
  'images/accessories/accessories4.jpg',
  'images/accessories/accessories5.jpg',
  'images/accessories/accessories6.jpg',
  'images/accessories/accessories7.jpg',
];

List<String> accessoriesLabel = [
  'hat',
  'men sunglass',
  'w sunglass',
  'classic watch',
  'gloves',
  'belt waist',
  'ring',
  'necklace',
  'scarf set',
  'anklet',
  'other'
];

// ignore: camel_case_types
class accessoriesCategory extends StatelessWidget {
  const accessoriesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'accessories',
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
            children: List.generate(accessoriessCat.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage(accessoriessCat[index]),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  Text(accessoriesLabel[index])
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
