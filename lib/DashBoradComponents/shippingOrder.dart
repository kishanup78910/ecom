import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Models/supplierModelOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Shipping extends StatelessWidget {
  const Shipping({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliveryStatus', isEqualTo: 'shipping')
          .snapshots(),
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
              'You have not \n \n active order !',
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
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return SupplierOrderModel(
                order: snapshot.data!.docs[index],
              );
            });
      },
    );
  }
}
