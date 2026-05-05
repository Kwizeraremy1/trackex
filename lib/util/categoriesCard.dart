import 'package:flutter/material.dart';

class Categoriescard extends StatelessWidget {
  final String Category;
  final String transactions;
  final IconData icon;
  final double amount;
  final IconData icon2;
  final double percentage;
  final Color Iconcolor;
  final Color Percentagecolor;
  const Categoriescard({
    required this.Category,
    required this.transactions,
    required this.icon,
    required this.amount,
    required this.icon2,
    required this.percentage,
    required this.Iconcolor,
    required this.Percentagecolor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(45, 28, 60, 115),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: const Color.fromARGB(117, 0, 52, 94))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(142, 0, 32, 88),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: const Color.fromARGB(148, 72, 139, 255))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        icon,
                        color: Iconcolor,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Category,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$transactions Transactions",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '- \$ $amount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon2,
                            size: 20,
                            color: Percentagecolor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${percentage.toStringAsFixed(2)}%',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                    CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 6,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(Iconcolor),
                    ),
                      Text("$percentage%", style: TextStyle(fontSize: 10),)
                    ]
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
