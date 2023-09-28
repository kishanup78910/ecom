// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:ecom/Models/wishModel.dart';

import 'package:ecom/providers/wish_provider.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

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

        actions: [
          context.watch<Wish>().getWishItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    MyAlertDialogue().showMyDialogue(
                        context: context,
                        title: 'Clear WishList',
                        content: 'Are you sure you want to clear Wishlist?',
                        tabNo: () {
                          Navigator.pop(context);
                        },
                        tabYes: () {
                          context.read<Wish>().clearWishList();
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(Icons.delete_forever, color: Colors.black),
                ),
        ],
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
              return wishListModel(product: product);
            });
      },
    );
  }
}
