import 'package:flutter/material.dart';
import './screens/HomeDashboard.dart';
import 'screens/CartPage.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomeDashboard(),
      //home: ProductPage(),
      //home:AddItemPage(),
    );
  }

}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
        child: const Text('Go to Cart'),
      ),
    ),
  );
}
