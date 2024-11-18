import 'package:flutter/material.dart';
import './screens/HomeDashboard.dart';
import './screens/ProductPage.dart';
import './screens/AddItemPage.dart';



void main() {
  runApp(const MyApp());
} // Returns the MaterialApp

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeDashboard(),
      // home: ProductPage(),
      // home:AddItemPage(),
    );
  }
}