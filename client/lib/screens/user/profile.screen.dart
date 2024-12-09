import 'package:client/main.dart';
import 'package:client/screens/user/edit.user.screen.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(219, 149, 50, 25),
              Colors.black
            ], // Chuyển màu từ tím sang đen
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 1.0], // Điểm dừng của gradient
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditUserScreen()),
                    )
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://ls1.in/avEjH", // Ảnh đại diện.
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tên Người dùng",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "0 người theo dõi",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  OutlinedButton(
                    child: const Text(
                      "Chinh sửa",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditUserScreen(),
                          ))
                    },
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 32,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Đảm bảo column chỉ chiếm không gian cần thiết
          children: [
            const SongWidget(), // Hiển thị song widget ở dưới
            NavigationWidget(
              currentIndex: 2,
              onTabSelected: (index) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      initialPage: index,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
