import 'package:flutter/material.dart';

class AuthMainButton extends StatelessWidget {
  final String mainButtonLabel;
  final Function() onPressed;
  const AuthMainButton({
    required this.mainButtonLabel,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,
          child: Text(mainButtonLabel,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;
  const HaveAccount({
    super.key,
    required this.haveAccount,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionLabel,
            style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        )
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  final String headerLable;
  const AuthHeaderLabel({
    super.key,
    required this.headerLable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLable,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            icon: const Icon(Icons.home_work),
          )
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  hintText: "Enter your name",
  labelText: "Name",
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.purpleAccent, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.purpleAccent, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
);
