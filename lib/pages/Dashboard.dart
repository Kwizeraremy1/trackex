import 'package:flutter/material.dart';
import 'package:trackex/Auth/authFunction.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/pages/AddIncome.dart';
import 'package:trackex/pages/addExpense.dart';
import 'package:trackex/pages/profile.dart';
import 'package:trackex/util/button1.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
                  return Container(
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
                              DateFormat('dd MMM yyyy').format(
                                DateTime.now(),
                              ),
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
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(71, 68, 137, 255)
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color.fromARGB(255, 120, 170, 255),
                                Colors.blueAccent,
                              ]),
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
                            Text(DateFormat('dd MMM yyyy').format(DateTime.now()),style: TextStyle(fontSize: 16),)
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
                              border: Border.all(width: 0.2, color: Colors.black)
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Balance", style: TextStyle(fontSize: 18,color: Colors.white)),
                  SizedBox(height: 5),
                  Text(
                    "Rwf 1,250.00",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 105, 240, 175),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: Colors.greenAccent)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, color: Colors.white, size: 16),
                        SizedBox(width: 5),
                        Text(
                          "Rwf 250.00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(70, 105, 240, 175),
                                shape: BoxShape.circle,
                                border: Border.all(width: 0.5, color: Colors.greenAccent)
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
                                  "Rwf 2,000.00",
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
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(70, 255, 82, 82),
                                shape: BoxShape.circle,
                                border: Border.all(width: 0.5, color: Colors.redAccent)
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
                                  "Rwf 2,000.00",
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
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
                                border: Border.all(width: 0.5, color: const Color.fromARGB(255, 0, 31, 84))
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Button1(
                    name: "Add Expense",
                    color: Colors.blueAccent,
                    colorAll: const Color.fromARGB(80, 68, 137, 255),
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Addexpense())),
                  ),
                  SizedBox(width: 5),
                  Button1(
                    name: "Add Income",
                    color: Colors.greenAccent,
                    colorAll: const Color.fromARGB(80, 105, 240, 175),
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Addincome())),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Recent Transactions", style: TextStyle(fontSize: 18)),
                Spacer(),
                Text("See all", style: TextStyle(color: Colors.blueAccent)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Today, '),
                Text(DateFormat('dd MMM').format(DateTime.now()),style: TextStyle(fontSize: 16),)
                          
              ],
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(45, 28, 60, 115),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.5, color: const Color.fromARGB(255, 0, 29, 52))
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
                                ]
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.5, color: const Color.fromARGB(62, 49, 137, 209))
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shopping", style: TextStyle(fontSize: 18)),
                              Text(
                                "Aug 15th, 2024",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "Rwf 150.00",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
