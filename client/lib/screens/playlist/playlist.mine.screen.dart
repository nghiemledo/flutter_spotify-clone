import 'package:client/screens/playlist/playlist.addsong.screen.dart';
import 'package:client/screens/playlist/playlist.edit.screen.dart';
import 'package:client/screens/playlist/playlist.screen.dart';
import 'package:flutter/material.dart';

class PlayListMineScreen extends StatelessWidget {
  const PlayListMineScreen({super.key});

  // Seach
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Tìm trong danh sách phát',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Sắp xếp",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                const SizedBox(height: 20),
                // Thanh search
                _buildSearchBar(),
                const SizedBox(height: 30),
                // Ảnh PlayList mine
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2015/02/21/20/05/dj-644557_640.jpg",
                      height: 280,
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tên PlayList
                const Text(
                  'DJ',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Ảnh người dùng - kèm tên
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'User',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Thanh tác vụ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_down_rounded, color: Colors.white70, size: 33),
                          onPressed: () { },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white70, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlaylistEditScreen()),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.delete_forever, color: Colors.white70, size: 30), onPressed: () {  },
                        ),
                      ],
                    ),

                    const Row(
                      children: [
                        Icon(Icons.shuffle, color: Colors.white70, size: 30),
                        SizedBox(width: 12),
                        Icon(Icons.play_circle, color: Colors.green, size: 65),
                      ],
                    ),
                  ],
                ),
                // Thanh thêm bài hát và PlayList
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white10,
                    ),
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.add, color: Colors.grey),
                  ),
                  title: const Text(
                    'Thêm vào danh sách phát này',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSongScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Bài hát có trong PlayList
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    // Sử dụng PlaylistItem cho bài hát có trong PlayList
                    return PlayListScreen(  
                      title: "Lời Tạm Biệt Chưa Nói",
                      author: "GREY D, Orange, Kai Đinh",
                      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFLUCy0cckz2AUEnf6hFfqK3U1vqSjMuK-Q&s",
                      icon: Icons.add_circle_outline,
                    );
                  },
                ),
                const SizedBox(height: 30),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bài hát Gợi ý",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "Dựa trên các bài hát trong playlist này",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Bài hát gợi ý
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    // Sử dụng PlaylistItem cho bài hát gợi ý
                    return PlayListScreen(  
                      title: "Lời Tạm Biệt Chưa Nói",
                      author: "GREY D, Orange, Kai Đinh",
                      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFLUCy0cckz2AUEnf6hFfqK3U1vqSjMuK-Q&s",
                      icon: Icons.add_circle_outline,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
