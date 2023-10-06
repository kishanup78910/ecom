import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/providers/product_class.dart';
import 'package:ecom/providers/wish_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class CartModel extends StatelessWidget {
  const CartModel({super.key, required this.product, required this.cart});

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(children: [
            SizedBox(
              height: 100,
              width: 120,
              child: Image.network(
                product.imagesUrl.first,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.price.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(children: [
                            product.qty == 1
                                ? IconButton(
                                    onPressed: () {
                                      showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoActionSheet(
                                          title: const Text('Remove Item'),
                                          message: const Text(
                                              'Are you sure want to remove?'),
                                          actions: <CupertinoActionSheetAction>[
                                            CupertinoActionSheetAction(
                                              /// This parameter indicates the action would be a default
                                              /// default behavior, turns the action's text to bold text.
                                              isDefaultAction: true,
                                              onPressed: () async {
                                                context
                                                            .read<Wish>()
                                                            .getWishItems
                                                            .firstWhereOrNull(
                                                                (element) =>
                                                                    element
                                                                        .documentId ==
                                                                    product
                                                                        .documentId) !=
                                                        null
                                                    ? context
                                                        .read<Cart>()
                                                        .removeItem(product)
                                                    : await context
                                                        .read<Wish>()
                                                        .addWishItem(
                                                            product.name,
                                                            product.price,
                                                            1,
                                                            product.qntty,
                                                            product.imagesUrl,
                                                            product.documentId,
                                                            product.suppId);
                                                context
                                                    .read<Cart>()
                                                    .removeItem(product);
                                              },
                                              child: const Text(
                                                  'Move to wishlist'),
                                            ),
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                context
                                                    .read<Cart>()
                                                    .removeItem(product);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Delete Item'),
                                            ),
                                            CupertinoActionSheetAction(
                                              /// This parameter indicates the action would perform
                                              /// a destructive action such as delete or exit and turns
                                              /// the action's text color to red.
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // cart.removeItem(product);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      size: 18,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      cart.decreament(product);
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.minus,
                                      size: 18,
                                    ),
                                  ),
                            Text(
                              product.qty.toString(),
                              style: product.qty == product.qntty
                                  ? const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Acme',
                                      color: Colors.red)
                                  : const TextStyle(
                                      fontSize: 20, fontFamily: 'Acme'),
                            ),
                            IconButton(
                              onPressed: product.qty == product.qntty
                                  ? null
                                  : () {
                                      cart.increament(product);
                                    },
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                size: 18,
                              ),
                            ),
                          ]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
