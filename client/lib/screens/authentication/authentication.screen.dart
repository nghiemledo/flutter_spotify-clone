import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(
                image: NetworkImage(
                    "data:image/png;base64,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")),
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
                Get.toNamed('/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text(
                'Sign up free',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // _buildButton(
            //     context, Icons.phone_android, 'Continue with phone number'),
            const SizedBox(height: 10),
            _buildButton(
                context, Icons.animation_rounded, 'Continue with Google'),
            // const SizedBox(height: 10),
            // _buildButton(context, Icons.facebook, 'Continue with Facebook'),
            // const SizedBox(height: 10),
            // _buildButton(context, Icons.apple, 'Continue with Apple'),
            const SizedBox(height: 10),
            // TextButton(
            //   onPressed: () {
            //     Get.toNamed('/login');
            //   },
            //   child: const Text(
            //     'Log in',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18),
            //   ),
            // ),
            // TextButton(
            //   onPressed: () {
            //     Get.toNamed('/register');
            //   },
            //   child: const Text(
            //     'Register',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18),
            //   ),
            // ),
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
