import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final name;
  final color;
  final VoidCallback onPressed;
  final colorAll;
  const Button1({
    super.key,
    this.name = "Button1",
    this.color = Colors.greenAccent,
    required this.colorAll,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: colorAll,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: color)
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            // right: 30,
            // left: 30,
            top: 15,
            bottom: 15,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.add, color: color, size: 18),
              ),
              SizedBox(width: 5),
              Text(name, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
