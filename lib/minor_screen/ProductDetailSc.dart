import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Models/productsModel.dart';
import 'package:ecom/minor_screen/fullScreen.dart';
import 'package:ecom/widgets/YelloButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({
    super.key,
    required this.proList,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imagesList = widget.proList['productimages'];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincategory', isEqualTo: widget.proList['maincategory'])
        .where(
          'subcategory',
          isEqualTo: widget.proList['subcategory'],
        )
        .snapshots();
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenView(imagesList: imagesList),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Swiper(
                        pagination: const SwiperPagination(
                            builder: SwiperPagination.fraction),
                        itemBuilder: (context, index) {
                          return Image(
                            image: NetworkImage(
                              imagesList[index],
                            ),
                          );
                        },
                        itemCount: imagesList.length,
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 25,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 25,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.share),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.proList['productname'],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'USD ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.proList['price'].toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Text(
                (widget.proList['quantity'].toString()) +
                    (' pieces avaialble in stock'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              const productDetailsHeader(
                label: '   Item Description   ',
              ),
              Text(
                widget.proList['productdescription'],
                textScaleFactor: 1.2,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const productDetailsHeader(
                label: '   Similar Item   ',
              ),
              SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _productStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.store,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
              YellowButton(
                label: 'ADD TO CART',
                onPressed: () {},
                width: 0.55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class productDetailsHeader extends StatelessWidget {
  final String label;
  const productDetailsHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.yellow.shade900,
            thickness: 1,
          ),
        ),
        Text(
          label,
          style: TextStyle(
              color: Colors.yellow.shade900,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.yellow.shade900,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}
