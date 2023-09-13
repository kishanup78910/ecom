// ignore: file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/widgets/Auth_widget.dart';
import 'package:ecom/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

class SupplierSignup extends StatefulWidget {
  const SupplierSignup({super.key});

  @override
  State<SupplierSignup> createState() => _SupplierSignupState();
}

class _SupplierSignupState extends State<SupplierSignup> {
  late String StoreName;
  late String StoreLogo;
  late String email;
  late String password;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisibilty = false;

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('suppler_logo/$email.jpg');

          await ref.putFile(File(_imageFile!.path));

          StoreLogo = await ref.getDownloadURL();
          _uid = FirebaseAuth.instance.currentUser!.uid;
          await suppliers.doc(_uid).set({
            'storeName': StoreName,
            'email': email,
            'storeLogo': StoreLogo,
            'phone': '',
            'address': '',
            'cid': _uid,
            'coverImage': ''
          });

          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });

          Navigator.pushReplacementNamed(context, '/supplier_home');

          myMessageHnadler.showSnackBar(
            _scaffoldKey,
            'Your id created 😊😊',
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            myMessageHnadler.showSnackBar(
              _scaffoldKey,
              'The password provided is too weak',
            );
            //  print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            myMessageHnadler.showSnackBar(
              _scaffoldKey,
              'The account already exists for that email.',
            );
            // print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        setState(() {
          processing = false;
        });
        myMessageHnadler.showSnackBar(
          _scaffoldKey,
          'Please pick an image',
        );
      }
    } else {
      setState(() {
        processing = false;
      });
      myMessageHnadler.showSnackBar(
        _scaffoldKey,
        'Please enter valid details',
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.yellow,
      //     content: Text(
      //       'Please enter valid details',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //           fontSize: 18, color: Colors.black),
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthHeaderLabel(headerLable: 'Sign Up'),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40),
                            child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.purpleAccent,
                                backgroundImage: _imageFile == null
                                    ? null
                                    : FileImage(File(_imageFile!.path))),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  color: Colors.white,
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.photo),
                                  color: Colors.white,
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Store Name';
                            }
                            return null;
                          },

                          onChanged: (value) {
                            StoreName = value;
                          },
                          //   controller: _nameController,
                          decoration: textFormDecoration.copyWith(
                            hintText: "Enter your Store Name",
                            labelText: "Store Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email Address';
                            } else if (value.isEmpty) {
                              return 'Please enter a valid email address';
                            } else if (value.isValidEmail() == false) {
                              return 'Please enter a valid email address';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          //  controller: _emailController,

                          onChanged: (value) {
                            email = value;
                          },

                          decoration: textFormDecoration.copyWith(
                            hintText: "Enter your email address",
                            labelText: "Email Address",
                          ),

                          // decoration: InputDecoration(
                          //   hintText: "Enter your email address",
                          //   labelText: "Email Address",
                          //   border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   enabledBorder: OutlineInputBorder(
                          //     borderSide: const BorderSide(
                          //         color: Colors.purpleAccent, width: 1),
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   focusedBorder: OutlineInputBorder(
                          //     borderSide: const BorderSide(
                          //         color: Colors.purpleAccent, width: 2),
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          // ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          //  controller: _passwordController,
                          onChanged: (value) {
                            password = value;
                          },

                          obscureText: passwordVisibilty,
                          decoration: textFormDecoration.copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibilty = !passwordVisibilty;
                                });
                              },
                              icon: Icon(passwordVisibilty
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.purple,
                            ),
                            hintText: "Enter your password",
                            labelText: "password",
                          ),
                          // decoration: InputDecoration(
                          //   hintText: "Enter your password",
                          //   labelText: "password",
                          //   border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   enabledBorder: OutlineInputBorder(
                          //     borderSide: const BorderSide(
                          //         color: Colors.purpleAccent, width: 1),
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   focusedBorder: OutlineInputBorder(
                          //     borderSide: const BorderSide(
                          //         color: Colors.purpleAccent, width: 2),
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          // ),
                        ),
                      ),
                      HaveAccount(
                          actionLabel: 'Log In',
                          haveAccount: 'Already have an account?',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/supplier_login');
                          }),
                      processing == true
                          ? const CircularProgressIndicator()
                          : AuthMainButton(
                              mainButtonLabel: 'Sign Up',
                              onPressed: () {
                                signUp();
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
