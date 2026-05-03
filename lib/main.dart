import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackex/Auth/authGate.dart';
import 'package:trackex/pages/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Supabase.initialize(
    url: "https://lgfcrexuvdxjlhmnhgjp.supabase.co",
    anonKey: "sb_secret_pce4OCQO7Lz9mW-KNRFF7w_RJRFTet2",
  );
  
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 19, 16, 36),
        scaffoldBackgroundColor: const Color.fromARGB(255, 19, 16, 36),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 19, 16, 36),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
