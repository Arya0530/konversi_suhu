import 'package:flutter/material.dart';
// Import file Page dari folder yang udah kita bikin
import 'konversi_suhu/konversi_suhu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konversi Suhu Cubit',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFB2DFDB), 
      ),
      // Langsung panggil Page-nya
      home: const KonversiSuhuPage(),
    );
  }
}