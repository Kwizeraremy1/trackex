import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/pages/transDetails.dart';
import 'package:trackex/util/historyCard.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    final db = Databasedata();
    return Expanded(
      child: FutureBuilder(
        future: db.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          print(snapshot.data);
          final hist = snapshot.data;
          return ListView.builder(
            itemCount: hist!.length,
            itemBuilder: (context, index) {
              final history = hist[index];
              return Historycard(
                title: history['category']['name'] ?? 'null',
                date: DateFormat('dd MMM yyyy').format(
                  DateTime.tryParse(history['created_at']) ?? DateTime.now(),
                ),
                amount: history['amount'].toString(),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionDetailPage(transaction: history),
                    ),
                  );
                  setState(() {
                    
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
