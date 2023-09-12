// ignore: file_names
import 'package:ecom/widgets/Auth_widget.dart';
import 'package:ecom/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  late String name;
  late String profileImage;
  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisibilty = false;

  void LogIn() async {
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/customer_home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          myMessageHnadler.showSnackBar(
            _scaffoldKey,
            'No user found for that email.',
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          myMessageHnadler.showSnackBar(
            _scaffoldKey,
            'Wrong password provided for that user.',
          );
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      myMessageHnadler.showSnackBar(
        _scaffoldKey,
        'Please enter valid details',
      );
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthHeaderLabel(headerLable: 'Log In'),
                      const SizedBox(
                        height: 50,
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
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      HaveAccount(
                          actionLabel: 'Sign Up',
                          haveAccount: 'Don\'t have an account?',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/customer_signup');
                          }),
                      processing == true
                          ? CircularProgressIndicator()
                          : AuthMainButton(
                              mainButtonLabel: 'Sign In',
                              onPressed: () {
                                LogIn();
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
