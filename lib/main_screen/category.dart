import 'package:ecom/categories_screen/Beauty_category.dart';
import 'package:ecom/categories_screen/HomeAndgardenCateogires.dart';
import 'package:ecom/categories_screen/accesories.dart';
import 'package:ecom/categories_screen/bags_category.dart';
import 'package:ecom/categories_screen/electronics_category.dart';
import 'package:ecom/categories_screen/kids_category.dart';
import 'package:ecom/categories_screen/main_category.dart';
import 'package:ecom/categories_screen/shoes_cateogory.dart';
import 'package:ecom/categories_screen/women_category.dart';
import 'package:ecom/main_screen/home.dart';
import 'package:flutter/material.dart';

List<ItemData> itmes = [
  ItemData(label: 'Men'),
  ItemData(label: 'Women'),
  ItemData(label: 'Shoes'),
  ItemData(label: 'Bags'),
  ItemData(label: 'Electronics'),
  ItemData(label: 'Accesories'),
  ItemData(label: 'Home & garden'),
  ItemData(label: 'Kids'),
  ItemData(label: 'Beauty'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in itmes) {
      element.isSelected = false;
    }
    setState(() {
      itmes[0].isSelected = true;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sideNavigator(size),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: categoryView(size),
          ),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: itmes.length,
          itemBuilder: (context, index) {
            // ignore: sized_box_for_whitespace
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.bounceInOut);
                // for (var element in itmes) {
                //   element.isSelected = false;
                // }
                // setState(() {
                //   itmes[index].isSelected = true;
                // });
              },
              child: Container(
                color: itmes[index].isSelected == true
                    ? Colors.white
                    : Colors.grey.shade300,
                height: 100,
                child: Center(
                  child: Text(
                    itmes[index].label,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget categoryView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in itmes) {
            element.isSelected = false;
          }
          setState(() {
            itmes[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WowomentCategory(),
          ShoesCategory(),
          bagsCategory(),
          electronicsCategory(),
          accessoriesCategory(),
          homegardenCategory(),
          kidsCategory(),
          beautyCategory(),
        ],
      ),
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}
