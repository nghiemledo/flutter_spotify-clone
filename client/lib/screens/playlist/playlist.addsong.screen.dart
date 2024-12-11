import 'package:client/screens/playlist/playlist.screen.dart';
import 'package:flutter/material.dart';

class AddSongScreen extends StatelessWidget {
  const AddSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thanh tiêu đề
            Container(
              color: Colors.black,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  const Text(
                    "Thêm vào danh sách phát này",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Thanh search
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3E3E3E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Được đề xuất',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Dựa trên các bài hát bạn vừa thêm vào',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            // List view PlayListItem
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF3E3E3E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const PlayListScreen(  // Sử dụng PlaylistItem
                    title: "Lời Tạm Biệt Chưa Nói",
                    author: "GREY D, Orange, Kai Đinh",
                    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFLUCy0cckz2AUEnf6hFfqK3U1vqSjMuK-Q&s",
                    icon: Icons.add_circle_outline,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
