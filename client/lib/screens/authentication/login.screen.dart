import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$';

  bool isValidEmail(String email) {
    return RegExp(emailRegex).hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(passwordRegex).hasMatch(password);
  }

  Future<void> login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email format')),
      );
      return;
    }

    if (!isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Password must contain at least 8 characters, 1 uppercase letter, 1 lowercase letter, and 1 special character')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/v1/auth/login'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['accessToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      final errorMessage =
          json.decode(response.body)['message'] ?? 'Login failed';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: GestureDetector(
                    onTap: () => {Get.back()},
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox())
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:
                        const Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                // padding: EdgeInsets.all(8.0),
                child: Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              child: GestureDetector(
                onTap: () => {Get.toNamed('/register')},
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
