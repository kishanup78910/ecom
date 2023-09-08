// ignore: file_names
import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const YellowButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.yellow,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
