// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:ecom/main_screen/customer_home.dart';
import 'package:ecom/providers/cart_provider.dart';

import 'package:ecom/providers/wish_provider.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    super.key,
  });

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: const AppBarBackButton(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'WishList'),
        //    actions: [
        // context.watch<Cart>().getItems.isEmpty
        //     ? const SizedBox()
        //     : IconButton(
        //         onPressed: () {
        //           MyAlertDialogue().showMyDialogue(
        //               context: context,
        //               title: 'Clear Cart',
        //               content: 'Are you sure you want to clear cart?',
        //               tabNo: () {
        //                 Navigator.pop(context);
        //               },
        //               tabYes: () {
        //                 context.read<Cart>().clearCart();
        //                 Navigator.pop(context);
        //               });
        //         },
        //         icon: const Icon(Icons.delete_forever, color: Colors.black),
        //       ),
        // ],
      ),
      body: context.watch<Wish>().getWishItems.isNotEmpty
          ? const WishItems()
          : const EmptyWishList(),
    );
  }
}

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your Wish List is empty !",
            style: TextStyle(fontSize: 30),
          ),
          // const SizedBox(height: 50),
          // Material(
          //   borderRadius: BorderRadius.circular(25),
          //   color: Colors.lightBlueAccent,
          //   child: MaterialButton(
          //     minWidth: MediaQuery.of(context).size.width * 0.6,
          //     onPressed: () {
          //       Navigator.canPop(context)
          //           ? Navigator.pop(context)
          //           : Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const CustomerHomeScreen(),
          //               ),
          //             );
          //     },
          //     child: const Text(
          //       'Continue Shopping',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
            itemCount: wish.getWishItems.length,
            itemBuilder: (context, index) {
              final product = wish.getWishItems[index];
              return Card(
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
                                  wish.getWishItems[index].price.toString(),
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
                                        context
                                            .read<Wish>()
                                            .removeItem(product);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                                    .read<Cart>()
                                                    .getItems
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element
                                                                .documentId ==
                                                            product
                                                                .documentId) !=
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
              );
            });
      },
    );
  }
}
