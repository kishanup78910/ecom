import 'package:ecom/minor_screen/ProductDetailSc.dart';
import 'package:ecom/providers/wish_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class productModel extends StatefulWidget {
  final dynamic products;
  const productModel({
    super.key,
    required this.products,
  });

  @override
  State<productModel> createState() => _productModelState();
}

class _productModelState extends State<productModel> {
  @override
  Widget build(BuildContext context) {
    var onSale = widget.products['price'];

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(
            proList: widget.products,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 100,
                      ),
                      child: Image.network(widget.products['productimages'][0]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.products['productname'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '\$',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  onSale.toStringAsFixed(2),
                                  style: widget.products['discount'] != 0
                                      ? const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold,
                                        )
                                      : const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ),
                                widget.products['discount'] != 0
                                    ? Text(
                                        ((1 -
                                                    (widget.products[
                                                            'discount'] /
                                                        100)) *
                                                onSale)
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ))
                                    : const Text(""),
                              ],
                            ),
                            widget.products['sid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      context
                                                  .read<Wish>()
                                                  .getWishItems
                                                  .firstWhereOrNull((product) =>
                                                      product.documentId ==
                                                      widget.products[
                                                          'productid']) !=
                                              null
                                          ? context.read<Wish>().removeThis(
                                              widget.products['productid'])
                                          : context.read<Wish>().addWishItem(
                                                widget.products['productname'],
                                                onSale != 0
                                                    ? ((1 -
                                                            (widget.products[
                                                                    'discount'] /
                                                                100)) *
                                                        onSale)
                                                    : widget.products['price'],
                                                1,
                                                widget.products['instock'],
                                                widget
                                                    .products['productimages'],
                                                widget.products['productid'],
                                                widget.products['sid'],
                                              );
                                    },
                                    icon: context
                                                .watch<Wish>()
                                                .getWishItems
                                                .firstWhereOrNull((product) =>
                                                    product.documentId ==
                                                    widget.products[
                                                        'productid']) !=
                                            null
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.red,
                                          )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.products['discount'] != 0
                ? Positioned(
                    top: 20,
                    left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            15,
                          ),
                          bottomRight: Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                            'Save ${widget.products['discount'].toString()} %'),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                  )
          ],
        ),
      ),
    );
  }
}
