import 'package:flutter/material.dart';

class PizzaHistoryScreen extends StatelessWidget {
  const PizzaHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza History'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_edu,
              size: 64,
              color: Color(0xFF8B4513),
            ),
            SizedBox(height: 16),
            Text(
              'Pizza History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon! The fascinating story of pizza.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}