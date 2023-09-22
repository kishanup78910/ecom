// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:ecom/main_screen/customer_home.dart';
import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:ecom/widgets/YelloButton.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: widget.back,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Cart'),
        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    MyAlertDialogue().showMyDialogue(
                        context: context,
                        title: 'Clear Cart',
                        content: 'Are you sure you want to clear cart?',
                        tabNo: () {
                          Navigator.pop(context);
                        },
                        tabYes: () {
                          context.read<Cart>().clearCart();
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(Icons.delete_forever, color: Colors.black),
                ),
        ],
      ),
      body: context.watch<Cart>().getItems.isNotEmpty
          ? const CartItems()
          : const EmptyCart(),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const Text(
                'Total: \$',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                context.watch<Cart>().totalPrice.toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          YellowButton(label: "CHECK OUT", onPressed: () {}, width: 0.45)
        ]),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your cart is empty !",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Material(
            borderRadius: BorderRadius.circular(25),
            color: Colors.lightBlueAccent,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.6,
              onPressed: () {
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerHomeScreen(),
                        ),
                      );
              },
              child: const Text(
                'Continue Shopping',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
            itemCount: cart.getItems.length,
            itemBuilder: (context, index) {
              final product = cart.getItems[index];
              return Card(
                child: SizedBox(
                  height: 100,
                  child: Row(children: [
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Image.network(
                        cart.getItems[index].imagesUrl.first,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cart.getItems[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cart.getItems[index].price.toString(),
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
                                              cart.removeItem(product);
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
              );
            });
      },
    );
  }
}
