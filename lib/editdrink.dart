import 'package:flutter/material.dart';

class EditDrink extends StatefulWidget {
  const EditDrink();

  @override
  State<EditDrink> createState() => _EditDrinkState();
}

class _EditDrinkState extends State<EditDrink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drink"),
      ),
    );
  }
}
