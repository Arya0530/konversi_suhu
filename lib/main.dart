import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
// Import halaman login dari folder auth lo
import 'auth/login_page.dart'; 

void main() async {
  // 2 Baris ini WAJIB untuk menyalakan mesin Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFB2DFDB), 
      ),
      // Halaman pertamanya kita arahkan ke halaman Login
      home: const LoginPage(),
    );
  }
}