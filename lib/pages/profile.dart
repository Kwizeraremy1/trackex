import 'package:flutter/material.dart';
import 'package:trackex/util/button2.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "R",
                        style: TextStyle(
                          fontSize: 200,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white38,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("email"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white38,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Telephone",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("phone"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                   Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white38,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Color.fromARGB(255, 19, 16, 36),
                            context: context,
                            isScrollControlled:
                                true, // <-- Makes it slide up fully
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
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      obscureText: true,
                                    ),
                                    SizedBox(height: 15),
              
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "New Password",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      obscureText: true,
                                    ),
                                    SizedBox(height: 15),
              
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Confirm Password",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
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
                    ),
                  ),
                ],
              ),
              Button2(
                name: "Logout",
                onPressed: () {},
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
