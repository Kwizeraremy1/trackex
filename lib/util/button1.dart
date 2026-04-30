import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final name;
  final color;
  final VoidCallback onPressed;
  const Button1({
    super.key,
    this.name = "Button1",
    this.color = Colors.greenAccent,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 40,
            left: 40,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
              SizedBox(width: 5),
              Text(name, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
