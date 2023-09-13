import 'package:ecom/auth/customer_login.dart';
import 'package:ecom/auth/customer_signUp.dart';
import 'package:ecom/auth/supplierLogin.dart';
import 'package:ecom/auth/supplier_signup.dart';
import 'package:ecom/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecom/main_screen/WelcomeScreen.dart';
import 'package:ecom/main_screen/customer_home.dart';
import 'package:ecom/main_screen/supplier_home.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/supplier_home': (context) => const SupplierHomeScreen(),
        '/customer_signup': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_login': (context) => const SupplierLogin(),
        '/supplier_signup': (context) => const SupplierSignup(),
      },
    );
  }
}
