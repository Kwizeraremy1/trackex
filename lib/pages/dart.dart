import 'package:flutter/material.dart';
import 'package:trackex/util/button2.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC9D6E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Color(0xFF4F6B85),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "R",
                            style: TextStyle(
                              fontSize: 200,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Remy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text("12"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("ID"), Text("id_number")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("DOB"), Text("dob")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Email"), Text("email")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Telephone"), Text("phone")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Address"), Text("address")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Gender"), Text("gender")],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Quick Settings",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // <-- Makes it slide up fully
                    shape: RoundedRectangleBorder(
                      // <-- Rounded corners like your UI
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(
                            context,
                          ).viewInsets.bottom, // keyboard safe
                          left: 20,
                          right: 20,
                          top: 30,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Change Password",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
          
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Old Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
          
                            TextField(
                              decoration: InputDecoration(
                                labelText: "New Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
          
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 25),
          
                            Button2(
                              name: "Save",
                              color: Colors.greenAccent,
                              onPressed: () {},
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.key_outlined),
                        SizedBox(width: 10),
                        Text("Change PIN"),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              SizedBox(height: 10),
          
              Button2(name: "Logout", onPressed: () {}, color: Colors.greenAccent),
              SizedBox(height: 20),
            ],

































          ),
        ),
      ),
    );
  }
}
