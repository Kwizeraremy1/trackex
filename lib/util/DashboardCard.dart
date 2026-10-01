import 'package:flutter/material.dart';
import 'package:trackex/database/databaseData.dart';

class Dashboardcard extends StatelessWidget {
  final double total;
  final double income;
  final double expense;
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
        Text(
          "Expense Compared to last month",
          style: TextStyle(fontSize: 14, color: Colors.white60),
        ),
        FutureBuilder(
          future: Databasedata().getMonthlyExpenditureDifference(),
          builder: (context, asyncSnapshot) {
            bool isLoading = asyncSnapshot.connectionState == ConnectionState.waiting;
            final difference = asyncSnapshot.data ?? 0;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isLoading ? const Color.fromARGB(99, 119, 120, 120) : difference > 0 ? const Color.fromARGB(100, 105, 240, 175) : const Color.fromARGB(100, 255, 82, 82),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color:isLoading ? const Color.fromARGB(99, 119, 120, 120) : difference > 0 ? const Color.fromARGB(100, 105, 240, 175) : const Color.fromARGB(100, 255, 82, 82)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading ? Text(".") : difference > 0 ? Icon(Icons.trending_up, color: Colors.white, size: 16) : Icon(Icons.trending_down, color: Colors.white, size: 16),
                  SizedBox(width: 5),
                  Text(isLoading ? "--" : "Rwf $difference", style: TextStyle(color: Colors.white)),
                ],
              ),
            );
          }
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
