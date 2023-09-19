// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:ecom/minor_screen/subcatag_products.dart';
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

// ignore: camel_case_types
class homegardenCategory extends StatelessWidget {
  const homegardenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: 0,
        left: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'homegarden',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: GridView.count(
                  mainAxisSpacing: 70,
                  crossAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: List.generate(homegardensCat.length - 1, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategory(
                                      subCatName: homegardenLabel[index + 1],
                                      mainCateName: 'Home and Garden',
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image(
                              image: AssetImage(homegardensCat[index + 1]),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Text(homegardenLabel[index + 1])
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50)),
                child: const RotatedBox(
                  quarterTurns: 3,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " << ",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 18),
                        ),
                        Text(
                          " Home And Garden ",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 18),
                        ),
                        Text(
                          " >> ",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 18),
                        ),
                      ]),
                ),
              ),
            )),
      )
    ]);
  }
}
