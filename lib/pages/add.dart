import 'package:flutter/material.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/util/calButton.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String textToDisplay1 = '0';
  String textToDisplay2 = '0';
  String? selected_category;
  String? selected_form;
  String? selected_form_Income;
  DateTime? Date;
  final db = Databasedata();

  void handleNumberPress(String num) {
    setState(() {
      if (textToDisplay1.length >= 12) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Maximum number of digits reached!")),
        );
      } else {
        if (textToDisplay1 == '0') {
          textToDisplay1 = num;
        } else {
          textToDisplay1 += num;
        }
      }
    });
  }

  void handleDelete() {
    setState(() {
      if (textToDisplay1.length > 1) {
        textToDisplay1 = textToDisplay1.substring(0, textToDisplay1.length - 1);
      } else {
        textToDisplay1 = '0';
      }
    });
  }

  void handleNumberPressIncome(String num) {
    setState(() {
      if (textToDisplay2.length >= 12) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Maximum number of digits reached!")),
        );
      } else {
        if (textToDisplay2 == '0') {
          textToDisplay2 = num;
        } else {
          textToDisplay2 += num;
        }
      }
    });
  }

  void handleDeleteIncome() {
    setState(() {
      if (textToDisplay2.length > 1) {
        textToDisplay2 = textToDisplay2.substring(0, textToDisplay2.length - 1);
      } else {
        textToDisplay2 = '0';
      }
    });
  }

  late final List ButtonsExpense = [
    CalButton(text: "1", onPressed: () => handleNumberPress('1')),
    CalButton(text: "2", onPressed: () => handleNumberPress('2')),
    CalButton(text: "3", onPressed: () => handleNumberPress('3')),
    CalButton(text: "4", onPressed: () => handleNumberPress('4')),
    CalButton(text: "5", onPressed: () => handleNumberPress('5')),
    CalButton(text: "6", onPressed: () => handleNumberPress('6')),
    CalButton(text: "7", onPressed: () => handleNumberPress('7')),
    CalButton(text: "8", onPressed: () => handleNumberPress('8')),
    CalButton(text: "9", onPressed: () => handleNumberPress('9')),
    CalButton(text: "<-", onPressed: () => handleDelete()),
    CalButton(text: "0", onPressed: () => handleNumberPress('0')),
    CalButton(text: "Send", buttonColor: Colors.blueAccent, onPressed: () {}),
  ];
  late final List ButtonsIncome = [
    CalButton(text: "1", onPressed: () => handleNumberPressIncome('1')),
    CalButton(text: "2", onPressed: () => handleNumberPressIncome('2')),
    CalButton(text: "3", onPressed: () => handleNumberPressIncome('3')),
    CalButton(text: "4", onPressed: () => handleNumberPressIncome('4')),
    CalButton(text: "5", onPressed: () => handleNumberPressIncome('5')),
    CalButton(text: "6", onPressed: () => handleNumberPressIncome('6')),
    CalButton(text: "7", onPressed: () => handleNumberPressIncome('7')),
    CalButton(text: "8", onPressed: () => handleNumberPressIncome('8')),
    CalButton(text: "9", onPressed: () => handleNumberPressIncome('9')),
    CalButton(text: "<-", onPressed: () => handleDeleteIncome()),
    CalButton(text: "0", onPressed: () => handleNumberPressIncome('0')),
    CalButton(text: "Send", buttonColor: Colors.greenAccent, onPressed: () {}),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add income/expense"), centerTitle: true),
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
                Tab(text: "Expense"),
                Tab(text: "Income"),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "AMOUNT",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              textToDisplay1,
                              style: TextStyle(
                                fontSize: 60,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rwf",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: FutureBuilder(
                                future: db.getCategory(),
                                builder: (context, Snapshot) {
                                  if (Snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white24,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [Text("Loading...")],
                                        ),
                                      ),
                                    );
                                  }
                                  final category = Snapshot.data;
                                  return DropdownButtonFormField(
                                    value: selected_category,
                                    style: TextStyle(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                    dropdownColor: const Color.fromARGB(
                                      255,
                                      70,
                                      59,
                                      131,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      labelText: "Select category",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    items: category?.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'].toString(),
                                        child: Text(item['name']),
                                      );
                                    }).toList(),
                                    onChanged: (item) {
                                      setState(() {
                                        selected_category = item!;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: DropdownButtonFormField(
                                style: TextStyle(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: const Color.fromARGB(
                                  255,
                                  70,
                                  59,
                                  131,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: "Form of payment",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                items: ['Cash', 'Momo', 'Bank', 'Loan'].map((
                                  item,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (item) {
                                  setState(() {
                                    selected_form = item!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                                bottom: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "To",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  maintainHintSize: true,
                                  labelText: "Add a note...",
                                  labelStyle: TextStyle(color: Colors.white54),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 320,
                              child: GridView.builder(
                                itemCount: ButtonsExpense.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 80,
                                      crossAxisCount: 3,
                                    ),
                                itemBuilder: (BuildContext, index) {
                                  return ButtonsExpense[index];
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "AMOUNT",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  textToDisplay2,
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rwf",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: DropdownButtonFormField(
                                style: TextStyle(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: const Color.fromARGB(
                                  255,
                                  70,
                                  59,
                                  131,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: "Via ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                items: ['Cash', 'Momo', 'Bank'].map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (item) {
                                  setState(() {
                                    selected_form_Income = item!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                                bottom: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "From",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  maintainHintSize: true,
                                  labelText: "Add a note...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 320,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ButtonsIncome.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 80,
                                      crossAxisCount: 3,
                                    ),
                                itemBuilder: (BuildContext, index) {
                                  return ButtonsIncome[index];
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
