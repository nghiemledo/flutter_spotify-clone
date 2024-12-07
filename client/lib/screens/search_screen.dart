// Tìm kiếm
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Tìm Kiếm",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
