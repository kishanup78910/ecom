// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> homegardensCat = [
  'images/homegarden/home0.jpg',
  'images/homegarden/home1.jpg',
  'images/homegarden/home2.jpg',
  'images/homegarden/home3.jpg',
  'images/homegarden/home4.jpg',
  'images/homegarden/home5.jpg',
  'images/homegarden/home6.jpg',
  'images/homegarden/home7.jpg',
  'images/homegarden/home8.jpg',
  'images/homegarden/home9.jpg',
];

List<String> homegardenLabel = [
  'living room',
  'bed room',
  'dinning room',
  'kitchen tools',
  'bath access.',
  'furniture',
  'decoration',
  'lighting',
  'garden',
  'other'
];

class homegardenCategory extends StatelessWidget {
  const homegardenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'homegarden',
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
            children: List.generate(homegardensCat.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage(homegardensCat[index]),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  Text(homegardenLabel[index])
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
