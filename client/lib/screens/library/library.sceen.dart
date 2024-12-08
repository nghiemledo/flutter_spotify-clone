import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Thư Viện",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}