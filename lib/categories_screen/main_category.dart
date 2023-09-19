// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/widgets/categoryModel.dart';
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoryHeaderLable(headerLabel: 'Men'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(MensCat.length - 1, (index) {
                        return subCategoryModel(
                          assetName: MensCat[index],
                          subcategLabel: menLable[index + 1],
                          subCategName: menLable[index + 1],
                          mainCategName: 'men',
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: slideBarwidget(maincategName: 'men'),
          )
        ],
      ),
    );
  }
}
