import 'package:ecom/widgets/Auth_widget.dart';
import 'package:ecom/widgets/snackbar.dart';
import 'package:flutter/material.dart';

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String name;
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisibilty = false;
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
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                            ),
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                              return 'Please enter your full Name';
                            }
                            return null;
                          },

                          onChanged: (value) {
                            name = value;
                          },
                          //   controller: _nameController,
                          decoration: textFormDecoration.copyWith(
                            hintText: "Enter your name",
                            labelText: "Name",
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
                          onPressed: () {}),
                      AuthMainButton(
                        mainButtonLabel: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            myMessageHnadler.showSnackBar(
                              _scaffoldKey,
                              'Your Id created successfully!😊',
                            );
                          } else {
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
