import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/util/colorsIcons.dart';
import 'package:trackex/util/historyCard.dart';

class Cathistory extends StatelessWidget {
  final name;
  final id;
  const Cathistory({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    final db = Databasedata();
    return Scaffold(
      appBar: AppBar(title: Text(name ?? "null"), centerTitle: true),
      body: FutureBuilder(
        future: db.getCatTransaction(id),
        builder: (context, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final data = Snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return Historycard(
                title: data[index]['category']['name'],
                date: DateFormat('dd MMM yyyy').format(DateTime.parse(data[index]['created_at'])),
                icon: CategoryIcons.icons[data[index]['category']['name']],
                amount: data[index]['amount'].toString(),);
            },
          );
        },
      ),
    );
  }
}
