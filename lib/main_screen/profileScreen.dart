// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/customerScreen/wishlist.dart';
import 'package:ecom/main_screen/CartScreen.dart';
import 'package:ecom/widgets/AppBarWidgets.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({super.key, required this.documentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');

    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");

          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(
              children: [
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.brown],
                    ),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 140,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: constraints.biggest.height < 120 ? 1 : 0,
                              child: const Text('Account'),
                            ),
                            background: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.yellow, Colors.brown],
                                ),
                              ),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0, top: 30),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(data['profileImage']),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    data['name'].toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: const Center(
                                      child: Text(
                                        'Cart',
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartScreen(
                                          back: AppBarBackButton(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                ),
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: const Center(
                                      child: Text(
                                        'Order',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartScreen(
                                          back: AppBarBackButton(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: const Center(
                                      child: Text(
                                        'WishList',
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WishListScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade300,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                                child: Image(
                                  image: AssetImage('images/inapp/logo.jpg'),
                                ),
                              ),
                              const ProfileHeaderLabel(
                                  headerLable: 'Account Info'),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      RepeatedListTile(
                                        icon: Icons.email,
                                        title: 'Email Address',
                                        subTitle: data['email'],
                                        onPressed: () {},
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Divider(
                                          color: Colors.yellow,
                                          thickness: 1,
                                        ),
                                      ),
                                      const RepeatedListTile(
                                        icon: Icons.phone,
                                        title: "Phone Number",
                                        subTitle: '+91XXXXXXXXXXX',
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Divider(
                                          color: Colors.yellow,
                                          thickness: 1,
                                        ),
                                      ),
                                      const RepeatedListTile(
                                          icon: Icons.location_pin,
                                          title: "Address",
                                          subTitle: "Phagwara Bus stand jdi")
                                    ],
                                  ),
                                ),
                              ),
                              const ProfileHeaderLabel(
                                headerLable: 'Account Settings',
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      RepeatedListTile(
                                        title: 'Edit Profile',
                                        icon: Icons.edit,
                                        subTitle: '',
                                        onPressed: () {},
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Divider(
                                          color: Colors.yellow,
                                          thickness: 1,
                                        ),
                                      ),
                                      RepeatedListTile(
                                        icon: Icons.lock,
                                        title: "Change Password",
                                        onPressed: () {},
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Divider(
                                          color: Colors.yellow,
                                          thickness: 1,
                                        ),
                                      ),
                                      RepeatedListTile(
                                        icon: Icons.logout,
                                        title: 'Logout',
                                        onPressed: () async {
                                          // Navigator.pushReplacementNamed(
                                          //     context, '/welcome_screen');

                                          MyAlertDialogue().showMyDialogue(
                                              context: context,
                                              title: 'Log Out',
                                              content:
                                                  'Are you sure to log out ?',
                                              tabNo: () {
                                                Navigator.pop(context);
                                              },
                                              tabYes: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.pop(context);
                                                Navigator.pushReplacementNamed(
                                                    context, '/welcome_screen');
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle = '',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLable;
  const ProfileHeaderLabel({super.key, required this.headerLable});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          "  $headerLable  ",
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}
