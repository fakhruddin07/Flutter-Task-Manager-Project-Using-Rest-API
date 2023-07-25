import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int number;
  final String title;
  const SummaryCard({super.key, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("$number"),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}