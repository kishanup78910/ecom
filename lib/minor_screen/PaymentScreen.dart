import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:ecom/widgets/YelloButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedValue = 1;
  late String orderId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progrss = ProgressDialog(context: context);
    progrss.show(
        max: 100, msg: 'Please wait..', progressBgColor: Colors.blueAccent);
  }

  @override
  Widget build(BuildContext context) {
    var totalPrice = context.watch<Cart>().totalPrice;
    var totalPaid = context.watch<Cart>().totalPrice + 10;
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
                child: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            // return Text("Full Name: ${data['full_name']} ${data['last_name']}");

            return Material(
              color: Colors.grey.shade200,
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Colors.grey.shade200,
                  title: const AppBarTitle(title: 'Payment'),
                  leading: const AppBarBackButton(),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                  child: Column(children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    '${totalPaid.toStringAsFixed(2)}  USD',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Cost',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    '10.00',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total order',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    totalPrice.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            RadioListTile(
                              value: 1,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as int;
                                });
                              },
                              title: const Text('Cash on delivery'),
                              subtitle: const Text('Pay when you receive'),
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as int;
                                });
                              },
                              title: const Text('Pay via Card'),
                              subtitle: const Row(children: [
                                Icon(
                                  Icons.payment,
                                  color: Colors.blueAccent,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    FontAwesomeIcons.ccMastercard,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.ccVisa,
                                  color: Colors.blueAccent,
                                )
                              ]),
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as int;
                                });
                              },
                              title: const Text('Pay via Paypal'),
                              subtitle: const Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.paypal,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 15),
                                  Icon(
                                    FontAwesomeIcons.ccPaypal,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                bottomSheet: Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YellowButton(
                      label: 'Confirm   ${totalPaid.toStringAsFixed(2)}   USD',
                      width: 1,
                      onPressed: () {
                        if (selectedValue == 1) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Pay at Home  ${totalPaid.toStringAsFixed(2)}   USD',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      YellowButton(
                                          label:
                                              'Confirm ${totalPaid.toStringAsFixed(2)}',
                                          onPressed: () async {
                                            showProgress();
                                            for (var item in context
                                                .read<Cart>()
                                                .getItems) {
                                              CollectionReference orderRef =
                                                  FirebaseFirestore.instance
                                                      .collection('orders');
                                              orderId = const Uuid().v4();

                                              await orderRef.doc(orderId).set({
                                                'cid': data['cid'],
                                                'customer_name': data['name'],
                                                'email': data['email'],
                                                'address': data['address'],
                                                'phone': data['phone'],
                                                'profileImage':
                                                    data['profileImage'],
                                                'sid': item.suppId,
                                                'proId': item.documentId,
                                                'orderId': orderId,
                                                'orderName': item.name,
                                                'orderImage':
                                                    item.imagesUrl.first,
                                                'orderqty': item.qty,
                                                'orderprice':
                                                    item.price * item.qty,
                                                'deliveryStatus': 'preparing',
                                                'deliveryDate': '',
                                                'orderdate': DateTime.now(),
                                                'paymentstatus':
                                                    'cash on delivery',
                                                'orderreview': false,
                                              }).whenComplete(() async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction(
                                                        (transaction) async {
                                                  DocumentReference
                                                      documentReference =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'products')
                                                          .doc(item.documentId);
                                                  DocumentSnapshot snapshot2 =
                                                      await transaction.get(
                                                          documentReference);
                                                  transaction.update(
                                                      documentReference, {
                                                    'instock':
                                                        snapshot2['instock'] -
                                                            item.qty
                                                  });
                                                });
                                              });
                                            }
                                            context.read<Cart>().clearCart();
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    '/customer_home'));
                                          },
                                          width: 0.9)
                                    ]),
                              ),
                            ),
                          );
                        } else if (selectedValue == 2) {
                        } else if (selectedValue == 3) {
                        } else if (selectedValue == 3) {}
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
