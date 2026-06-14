import 'package:flutter/material.dart';

class Dashboardcard extends StatelessWidget {
  final total;
  final income;
  final expense;
  const Dashboardcard({super.key, required this.expense, required this.income, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Total Balance",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          "Rwf $total",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: total < 0 ? Colors.red : Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(100, 105, 240, 175),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.greenAccent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 16),
              SizedBox(width: 5),
              Text("Rwf 200", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 105, 240, 175),
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.5, color: Colors.greenAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      "Rwf $income",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Total income",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 255, 82, 82),
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.5, color: Colors.redAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      "Rwf $expense",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Total expenses",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
