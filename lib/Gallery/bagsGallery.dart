import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Models/productsModel.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class BagsGalleryScreen extends StatefulWidget {
  const BagsGalleryScreen({super.key});

  @override
  State<BagsGalleryScreen> createState() => _BagsGalleryScreenState();
}

class _BagsGalleryScreenState extends State<BagsGalleryScreen> {
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincategory', isEqualTo: 'bags')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text(
            'This category has \n \n no items yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acme',
                letterSpacing: 1.5),
          ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'This category has \n \n no items yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Acme',
                  letterSpacing: 1.5),
            ),
          );
        }

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return productModel(
                products: snapshot.data!.docs[index],
              );
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
          ),
        );

        //  ListView(
        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //     Map<String, dynamic> data =
        //         document.data()! as Map<String, dynamic>;
        //     return ListTile(
        //       leading: Image.network(data['productimages'][0]),
        //       title: Text(data['productname']),
        //       subtitle: Text(data['price'].toString()),
        //     );
        //   }).toList(),
        // );
      },
    );
  }
}
