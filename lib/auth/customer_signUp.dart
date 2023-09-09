import 'package:ecom/widgets/Auth_widget.dart';
import 'package:flutter/material.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisibilty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            return 'Please enter your Email Address';
                          }
                          return null;
                        },
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
                            return 'Please enter your full Name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,

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
                          print('Validated');
                        } else {
                          print('Not Validated');
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
    );
  }
}
