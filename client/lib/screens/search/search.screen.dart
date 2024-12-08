import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
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
