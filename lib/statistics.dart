import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics();

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
      ),
    );
  }
}
