import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final name;
  final color;
  final VoidCallback onPressed;
  const Button2({
    required this.onPressed,
    required this.name,
    required this.color,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
