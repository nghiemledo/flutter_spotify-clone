// Thư viện
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

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
