import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/tela.dart';
import 'package:flutter_application_1/telafilme.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/tela',
      routes: {
        '/tela': (context) => Login(),
        '/telafilme': (context) => FilmesScreen(),
      },
    );
  }
}