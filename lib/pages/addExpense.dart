import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/util/calButton.dart';

class Addexpense extends StatefulWidget {
  const Addexpense({super.key});

  @override
  State<Addexpense> createState() => _AddexpenseState();
}

class _AddexpenseState extends State<Addexpense> {
  String textToDisplay1 = '0';
  final addNote = TextEditingController();
  final To = TextEditingController();
  String? selected_category;
  String? selected_form;
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

  void upLoad() async {
    final form = selected_form;
    final cat = selected_category;
    final Add = addNote.text;
    int? finalAmount = int.tryParse(textToDisplay1);
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final to = To.text;
    if (finalAmount == 0) {
      print("you can't spend 0 Rwf");
      return;
    } else if (cat == null) {
      print("please!!!!!, Select where you are spending to");
      return;
    } else if (form == null) {
      print("Enter form of payment");
    } else if (to.isEmpty) {
      print("please!!!!!, Enter who you are giving money to");
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Center(child: CircularProgressIndicator()),
          );
        },
      );
      try {
        final amount = await supabase
            .from('expense')
            .select()
            .eq('profileId', userId)
            .maybeSingle();
        int? total = amount?['amount'] as int?;

        if (amount == null) {
          await supabase.from('expense').insert({
            'profileId': userId,
            'amount': int.tryParse(textToDisplay1),
          });
          await supabase.from('transactions').insert({
            'profileId': userId,
            'amount': int.tryParse(textToDisplay1),
            'CategoryId': int.tryParse(cat),
            'type': form,
            'to': to,
            'note': Add,
          });
        } else {
          total = (total ?? 0) + (finalAmount ?? 0);
          await supabase.from('expense').insert({
            'profileId': userId,
            'amount': total,
          });
          await supabase.from('transactions').insert({
            'profileId': userId,
            'amount': userId,
            'Category': int.tryParse(cat),
            'type': form,
            'to': to,
            'note': Add,
          });
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
        Navigator.pop(context);
      }
    }
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
    CalButton(
      text: "Send",
      buttonColor: Colors.white,
      onPressed: () => upLoad(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppBar(
            title: Text(
              "Add Expense",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            centerTitle: true,
            leading: BackButton(color: Colors.blueAccent),
          ),
          Text("AMOUNT", style: TextStyle(color: Colors.grey, fontSize: 18)),
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
                textToDisplay1,
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: FutureBuilder(
                  future: db.getCategory(),
                  builder: (context, Snapshot) {
                    if (Snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Row(
                            children: [SizedBox(width: 20), Text("Loading...")],
                          ),
                        ),
                      );
                    }
                    final category = Snapshot.data;
                    return DropdownButtonFormField(
                      value: selected_category,
                      style: TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: const Color.fromARGB(255, 70, 59, 131),
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
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: DropdownButtonFormField(
                  style: TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  dropdownColor: const Color.fromARGB(255, 70, 59, 131),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Form of payment",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: ['Cash', 'Momo', 'Bank', 'Loan'].map((item) {
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
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: TextField(
                  controller: To,
                  decoration: InputDecoration(
                    labelText: "To",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: TextField(
                  controller: addNote,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    maintainHintSize: true,
                    labelText: "Add a note...",
                    labelStyle: TextStyle(color: Colors.grey),
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
              itemCount: ButtonsExpense.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 80,
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext, index) {
                return ButtonsExpense[index];
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
