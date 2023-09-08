// ignore: file_names
// ignore: file_names
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecom/auth/customer_signUp.dart';
import 'package:ecom/widgets/YelloButton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/inapp/bgimage.jpg'),
                fit: BoxFit.cover),
          ),
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'WELCOME',
                    textStyle: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme',
                    ),
                    colors: [
                      Colors.yellowAccent,
                      Colors.red,
                      Colors.blueAccent,
                      Colors.green,
                      Colors.purple,
                      Colors.teal
                    ],
                  ),
                  ColorizeAnimatedText(
                    'DUCK STORE',
                    textStyle: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme',
                    ),
                    colors: [
                      Colors.yellowAccent,
                      Colors.red,
                      Colors.blueAccent,
                      Colors.green,
                      Colors.purple,
                      Colors.teal
                    ],
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),

              // const Text(
              //   "WELCOME",
              //   style: TextStyle(color: Colors.white, fontSize: 30),
              // ),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),

              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontFamily: 'Acme',
                      fontSize: 30),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('Duck Store'),
                    ],
                    repeatForever: true,
                    isRepeatingAnimation: true,
                  ),
                ),
              ),
              //  const Text(
              //  "SHOP",
              //   style: TextStyle(color: Colors.white, fontSize: 30),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Suppliers only',
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedBuilder(
                                  animation: _controller.view,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _controller.value * 2 * 3.14,
                                      child: child,
                                    );
                                  },
                                  child: const Image(
                                    image: AssetImage('images/inapp/logo.jpg'),
                                  ),
                                ),
                                YellowButton(
                                    label: 'Log In',
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/supplier_home',
                                      );
                                    },
                                    width: 0.25),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: YellowButton(
                                      label: 'Sign Up',
                                      onPressed: () {},
                                      width: 0.25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: YellowButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/customer_home',
                                  );
                                },
                                width: 0.25),
                          ),
                          YellowButton(
                              label: 'Sign Up',
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerRegister()),
                                );
                              },
                              width: 0.25),
                          AnimatedBuilder(
                            animation: _controller.view,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _controller.value * 2 * 3.14,
                                child: child,
                              );
                            },
                            child: const Image(
                              image: AssetImage('images/inapp/logo.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Google Sign in
                    GoogleFacebookLogin(
                      label: 'Google',
                      onPressed: () {},
                      child: const Image(
                        image: AssetImage('images/inapp/google.jpg'),
                      ),
                    ),

                    // Facebook Sign in

                    GoogleFacebookLogin(
                      label: 'Facebook',
                      onPressed: () {},
                      child: const Image(
                        image: AssetImage('images/inapp/facebook.jpg'),
                      ),
                    ),

                    GoogleFacebookLogin(
                        label: 'Guest',
                        onPressed: () {},
                        child: const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.lightBlueAccent,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const GoogleFacebookLogin({
    super.key,
    required this.label,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(height: 50, width: 50, child: child),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
