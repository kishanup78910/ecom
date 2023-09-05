// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> electronicssCat = [
  'images/electronics/electronics0.jpg',
  'images/electronics/electronics1.jpg',
  'images/electronics/electronics2.jpg',
  'images/electronics/electronics3.jpg',
  'images/electronics/electronics4.jpg',
  'images/electronics/electronics5.jpg',
  'images/electronics/electronics6.jpg',
  'images/electronics/electronics7.jpg',
  'images/electronics/electronics8.jpg',
  'images/electronics/electronics9.jpg',
  'images/electronics/electronics10.jpg',
  'images/electronics/electronics11.jpg',
  'images/electronics/electronics12.jpg',
  'images/electronics/electronics13.jpg',
];

List<String> electronicsLabel = [
  'phone',
  'computer',
  'laptop',
  'smart tv',
  'phone holder',
  'charger',
  'usb cables',
  'head phone',
  'smart watch',
  'tablet',
  'mouse',
  'keyboard',
  'gaming',
  'other'
];

// ignore: camel_case_types
class electronicsCategory extends StatelessWidget {
  const electronicsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'electronics',
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
            children: List.generate(electronicssCat.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage(electronicssCat[index]),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  Text(electronicsLabel[index])
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
