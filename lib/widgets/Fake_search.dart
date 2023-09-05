// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:ecom/minor_screen/search.dart';
import 'package:flutter/material.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow, width: 1.9),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            Container(
                height: 32,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
