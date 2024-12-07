// Trang chủ
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Trang Chủ",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
