// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/minor_screen/visit_store.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:flutter/material.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Stores'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return visitStore(
                              supplierId: snapshot.data!.docs[index]['cid'],
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Positioned(
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.network(
                                      snapshot.data!.docs[index]['storeLogo'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data!.docs[index]['storeName']
                                  .toLowerCase(),
                              style: const TextStyle(
                                  fontSize: 24, fontFamily: 'Acme'),
                            ),
                          ],
                        ),
                      );
                    });
              }
              return const Center(
                  child: Text('No stores found! Try again later!'));
            },
            stream:
                FirebaseFirestore.instance.collection("suppliers").snapshots(),
          ),
        ));
  }
}
