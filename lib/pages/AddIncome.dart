import 'package:flutter/material.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/functions/Functions.dart';
import 'package:trackex/util/calButton.dart';

class Addincome extends StatefulWidget {
  const Addincome({super.key});

  @override
  State<Addincome> createState() => _AddincomeState();
}

class _AddincomeState extends State<Addincome> {
  TextEditingController fromController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String textToDisplay2 = '0';
  // String? selected_category;
  // String? selected_form;
  String? selected_form_Income;
  DateTime? Date;
  final db = Databasedata();
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

  late final List ButtonsIncome = [
    CalButton(
      text: "1",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('1'),
    ),
    CalButton(
      text: "2",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('2'),
    ),
    CalButton(
      text: "3",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('3'),
    ),
    CalButton(
      text: "4",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('4'),
    ),
    CalButton(
      text: "5",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('5'),
    ),
    CalButton(
      text: "6",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('6'),
    ),
    CalButton(
      text: "7",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('7'),
    ),
    CalButton(
      text: "8",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('8'),
    ),
    CalButton(
      text: "9",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('9'),
    ),
    CalButton(
      text: "<-",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleDeleteIncome(),
    ),
    CalButton(
      text: "0",
      buttonColor: Colors.greenAccent,
      onPressed: () => handleNumberPressIncome('0'),
    ),
    CalButton(
      text: "Send",
      buttonColor: Colors.white,
      onPressed: () {
        Functions().AddIncome(
          context,
          textToDisplay2,
          selected_form_Income!,
          fromController.text,
          noteController.text,
        );
        Navigator.pop(context);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBar(
              title: Text(
                "Add Income",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              centerTitle: true,
              leading: BackButton(color: Colors.greenAccent),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AMOUNT",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Rwf",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      textToDisplay2,
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: DropdownButtonFormField(
                    style: TextStyle(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    dropdownColor: const Color.fromARGB(255, 70, 59, 131),
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
                    controller: fromController,
                    decoration: InputDecoration(
                      labelText: "From",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      maintainHintSize: true,
                      labelText: "Add a note...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 320,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: ButtonsIncome.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
