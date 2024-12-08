import 'package:client/screens/playlist/playlist.create.screen.dart';
import 'package:client/screens/user/favoritelist.screen.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Animation cho SlideTransition
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Bắt đầu ngoài màn hình bên trái
      end: Offset.zero, // Kết thúc ở giữa màn hình
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Nền gradient chính
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 37, 4, 78), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với hình ảnh và các nút
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _controller.forward();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  "https://ls1.in/avEjH",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Thư Viện",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: _showAddMenu,
                            icon: const Icon(Icons.add, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Danh sách thư viện
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildLibraryItem(
                        imageUrl: "https://example.com/favorite_image.jpg",
                        text: "Bài hát đã thích",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoriteListScreen(),
                            ),
                          );
                        },
                      ),
                      _buildLibraryItem(
                        imageUrl: "https://example.com/album_image.jpg",
                        text: "Album",
                        onTap: () {},
                      ),
                      _buildLibraryItem(
                        imageUrl: "https://example.com/playlist_image.jpg",
                        text: "Playlist của tôi",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu trượt bằng SlideTransition
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Menu User",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.reverse(); // Đóng menu
                    },
                    child: const Text("Đóng"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo mục thư viện
  Widget _buildLibraryItem({
    required String imageUrl,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Hàm hiển thị menu thêm danh sách phát
  void _showAddMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 24, 24, 24),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListTile(
            leading: const Icon(Icons.playlist_add, color: Colors.white),
            title: const Text(
              "Danh sách phát",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaylistCreateScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
