import 'package:flutter/material.dart';
class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add income/expense"),centerTitle: true,),
      body: DefaultTabController(
        length: 2,
        child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            indicatorColor: Colors.transparent,
            tabs: [
            Tab(
              text: "Expense",
            ),
            Tab(
              text: "Income",
            )
          ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: TabBarView(children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(30, 255, 82, 82),
                          border: Border.all(width:2, color:  const Color.fromARGB(145, 244, 67, 54)),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("AMOUNT", style: TextStyle(color: Colors.grey,fontSize: 18),),
                            SizedBox(height: 10,),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
               Container(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(30, 76, 175, 79),
                          border: Border.all(width:2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("AMOUNT", style: TextStyle(color: Colors.grey,fontSize: 18),),
                            SizedBox(height: 10,),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )
          )
        ],
      )),
    );
  }
}