import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView để nội dung có thể cuộn
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(
                image: NetworkImage(
                    '')), // Hình ảnh có thể được thay thế bằng URL hợp lệ
            const Text(
              'Millions of songs.\nFree on Spotify.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const MainScreen(initialPage: 0));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Sign up free',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildButton(
                context, Icons.phone_android, 'Continue with phone number'),
            const SizedBox(height: 10),
            _buildButton(
                context, Icons.animation_rounded, 'Continue with Google'),
            const SizedBox(height: 10),
            _buildButton(context, Icons.facebook, 'Continue with Facebook'),
            const SizedBox(height: 10),
            _buildButton(context, Icons.apple, 'Continue with Apple'),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String text) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }
}
