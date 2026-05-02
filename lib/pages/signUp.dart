import 'package:flutter/material.dart';
import 'package:trackex/pages/login.dart';
import 'package:trackex/util/button2.dart';
class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Sign up", style: TextStyle(fontSize: 30),),
              SizedBox(height: 30,),
              TextField(                
                    decoration: InputDecoration(
                      labelText: "Names",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
              ),
              SizedBox(height: 10,),
              TextField(
                    decoration: InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),),
              SizedBox(height: 10,),
              TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),),
              SizedBox(height: 10,),
              TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),),
              SizedBox(height: 10,),
              TextField(
                    decoration: InputDecoration(
                      labelText: "Confirm Passsword",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),),
              SizedBox(height: 20,),
              Button2(onPressed: (){}, name: "Sign up", color: Colors.greenAccent),
              SizedBox(height: 10,),
              Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Don't have an account? ", style: TextStyle(fontSize: 16),),
                      InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
                        child: Text("Create Account", style: TextStyle(fontSize: 16, color: Colors.blueAccent))),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}