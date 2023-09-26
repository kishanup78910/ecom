import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/providers/product_class.dart';
import 'package:ecom/providers/wish_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class wishListModel extends StatelessWidget {
  const wishListModel({
    super.key,
    required this.product,
  });

  final Product product;

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
                product.imagesUrl[0],
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
                          product.price.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
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
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Move to wishlist'),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          context
                                              .read<Wish>()
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
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            context.watch<Cart>().getItems.firstWhereOrNull(
                                        (element) =>
                                            element.documentId ==
                                            product.documentId) !=
                                    null
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      context
                                                  .read<Cart>()
                                                  .getItems
                                                  .firstWhereOrNull((element) =>
                                                      element.documentId ==
                                                      product.documentId) !=
                                              null
                                          ? print('already in cart')
                                          : context.read<Cart>().addItem(
                                                product.name,
                                                product.price,
                                                1,
                                                product.qntty,
                                                product.imagesUrl,
                                                product.documentId,
                                                product.suppId,
                                              );
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart_checkout_outlined,
                                    ),
                                  ),
                          ],
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
