import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Models/productsModel.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class visitStore extends StatefulWidget {
  final String supplierId;
  const visitStore({super.key, required this.supplierId});

  @override
  State<visitStore> createState() => _visitStoreState();
}

class _visitStoreState extends State<visitStore> {
  bool following = false;
  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');

    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.supplierId)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.supplierId).get(),
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Image.asset(
                'images/inapp/coverimage.jpg',
                fit: BoxFit.cover,
              ),
              leading: const YellowBackButton(),
              title: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        data['storeLogo'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['storeName'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Acme',
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        data['cid'] == FirebaseAuth.instance.currentUser!.uid
                            ? Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: MaterialButton(
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Edit'),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                              )
                            : Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    print(data['cid']);
                                    print(
                                        FirebaseAuth.instance.currentUser!.uid);

                                    setState(() {
                                      following = !following;
                                    });
                                  },
                                  child: following == true
                                      ? const Text(
                                          'Following',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Acme',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text(
                                          'Follow',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Acme',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _productStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'This Store has \n \n no items yet',
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
                    return const Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'This Store has \n \n no items yet',
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

                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return productModel(
                          products: snapshot.data!.docs[index],
                        );
                      },
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
