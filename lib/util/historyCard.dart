import 'package:flutter/material.dart';

class Historycard extends StatelessWidget {
  final title;
  final date;
  final amount;
  final VoidCallback? onTap;
  const Historycard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(45, 28, 60, 115),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 0.5,
              color: const Color.fromARGB(255, 0, 29, 52),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(117, 0, 44, 119),
                        const Color.fromARGB(104, 0, 14, 37),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: const Color.fromARGB(62, 49, 137, 209),
                    ),
                  ),
                  child: Icon(
                    title == 'income' ? Icons.attach_money : Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title == 'income' ? 'Recieved' : title,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(date, style: TextStyle(color: Colors.red)),
                  ],
                ),
                Spacer(),
                Text(
                  amount,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
