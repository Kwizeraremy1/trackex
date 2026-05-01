import 'package:flutter/material.dart';

class CalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final buttonColor;
  const CalButton({this.onPressed, required this.text, this.buttonColor = Colors.white54,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Container(
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: buttonColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
