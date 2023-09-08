// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:ecom/main_screen/customer_home.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:ecom/widgets/YelloButton.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading: widget.back,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Cart'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever, color: Colors.black),
          ),
        ],
      ),
      body: Center(
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
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Row(
            children: [
              Text(
                'Total: \$',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                ' 00.00',
                style: TextStyle(
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
