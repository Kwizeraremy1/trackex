import 'package:flutter/material.dart';
import 'package:trackex/pages/Home.dart';
import 'package:trackex/util/button2.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(30, 255, 255, 255),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "track",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "Ex",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  Text("Master Your Finances, Simplify Your Life"),
                  SizedBox(height: 20),
                  TextField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: OutlineInputBorder(                        
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Button2(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    name: "Login",
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
