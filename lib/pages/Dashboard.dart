import 'package:flutter/material.dart';
import 'package:trackex/Auth/authFunction.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/pages/AddIncome.dart';
import 'package:trackex/pages/addExpense.dart';
import 'package:trackex/pages/history.dart';
import 'package:trackex/pages/profile.dart';
import 'package:trackex/util/button1.dart';
import 'package:intl/intl.dart';
import 'package:trackex/util/historyCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final suth = Authfunction();
    final db = Databasedata();
    void signOut() async {
      await suth.SignOut();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            FutureBuilder(
              future: db.getProfile(),
              builder: (context, Snapshot) {
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Icon(Icons.person_2_rounded)),
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loading Name...",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(DateTime.now()),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                final profile = Snapshot.data;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      (MaterialPageRoute(builder: (context) => Profile())),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(71, 68, 137, 255),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 120, 170, 255),
                                  Colors.blueAccent,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${profile?['names']?[0] ?? "0"}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, ${profile?['names'] ?? "No name"}",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(DateTime.now()),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => signOut(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.2,
                                color: Colors.black,
                              ),
                            ),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder(
                future: db.getDashPane(),
                builder: (context, Snapshot) {
                  if (Snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final pane = Snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text("Rwf ${pane['totalBalance']}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color:pane['totalBalance'] < 0 ?Colors.red: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(100, 105, 240, 175),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.greenAccent,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text("Rwf 200",
                              style: TextStyle(color: Colors.white),
                            ),
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
                                  color: const Color.fromARGB(
                                    70,
                                    105,
                                    240,
                                    175,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.greenAccent,
                                  ),
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
                                  Text("Rwf ${pane['incomeValue']}",
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
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.redAccent,
                                  ),
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
                                  Text("Rwf ${pane['expenseValue']}",
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
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 100,
                      width: 170,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(45, 28, 60, 115),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 0.5,
                          color: const Color.fromARGB(255, 0, 31, 84),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.blueGrey,
                              size: 25,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Rwf 150.00",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Shopping",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button1(
                  name: "Add Expense",
                  color: Colors.blueAccent,
                  colorAll: const Color.fromARGB(30, 68, 137, 255),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Addexpense()),
                    );
                    setState(() {});
                  },
                ),
                Button1(
                  name: "Add Income",
                  color: Colors.greenAccent,
                  colorAll: const Color.fromARGB(30, 105, 240, 175),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Addincome()),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Recent Transactions", style: TextStyle(fontSize: 13)),
                Spacer(),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>History())),
                  child: Text("See all", style: TextStyle(color: Colors.blueAccent))),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Today, '),
                Text(
                  DateFormat('dd MMM').format(DateTime.now()),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            FutureBuilder(
              future: db.getTransactions(),
              builder: (context, Snapshot) {
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (Snapshot.hasError) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(child: Text("Error fetching transactions")),
                  );
                }
                if (!Snapshot.hasData || Snapshot.data!.isEmpty) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(child: Text("No transactions found")),
                  );
                }
                final transactions = Snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Historycard(
                      title:
                          transactions[index]['category']['name'] ?? "No title",
                      date: DateFormat('dd MMM yyyy').format(
                        DateTime.parse(
                          transactions[index]['created_at'] ??
                              DateTime.now().toString(),
                        ),
                      ),
                      amount: transactions[index]['amount'].toString(),
                    );
                  },
                  itemCount: transactions!.length <= 3
                      ? transactions.length
                      : 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
