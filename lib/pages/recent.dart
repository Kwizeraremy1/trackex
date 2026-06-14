import 'package:flutter/material.dart';
import 'package:trackex/pages/histPages/all.dart';
import 'package:trackex/pages/histPages/income.dart';
import 'package:trackex/pages/histPages/expense.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          centerTitle: true,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Expenses'),
              Tab(text: 'Income'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: const TabBarView(
            children: [
              All(),            
              Expense(),
              Income(),
            ],
          ),
        ),
      ),
    );
  }
}