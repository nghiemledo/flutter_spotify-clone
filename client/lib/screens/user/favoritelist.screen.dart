import 'dart:convert';

import 'package:client/main.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  bool _isFavorite = false;
  // Khởi tạo danh sách nhạc yêu thích
  List<dynamic> _favoriteSongs = [];

  // Hàm xử lý yêu thích
  void _handlerFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; // Thay đổi trạng thái yêu thích
    });
  }

// Hàm fetch dữ liệu từ API
  Future<void> _fetchFavoriteSongs() async {
    final url = Uri.parse('http://localhost:3000/api/songs/favorites');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _favoriteSongs = data;
        });
      } else {
        print('Failed to load favorite songs');
      }
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFavoriteSongs(); // Gọi API khi khởi tạo
  }

  // Hàm mở Bottom Sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 500, // Chiều cao của bottom sheet
            child: Wrap(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.remove,
                    color: Colors.grey[600],
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSongInfo(),
                const Divider(color: Colors.grey),
                _buildActionRow(
                  Icons.favorite,
                  "Thêm vào danh sách yêu thích",
                  _handlerFavorite,
                ),
                _buildActionRow(Icons.add, "Thêm vào danh sách phát", () {}),
                _buildActionRow(Icons.album, "Đến album", () {}),
                _buildActionRow(Icons.person, "Đến nghệ sĩ", () {}),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 37, 4, 78), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nút quay lại
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
              // Tiêu đề
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8, left: 16),
                child: Text(
                  'Bài hát đã thích',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              // Số lượng bài hát
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '1 Bài hát',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
              // Thanh phát nhạc
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.download_for_offline_outlined,
                          color: Colors.grey,
                          size: 30,
                        )),
                    Row(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.play_circle,
                              color: Colors.green, size: 55),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // Danh sách nhạc
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _favoriteSongs.isEmpty
                        // Đang tải
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: _favoriteSongs.length,
                            itemBuilder: (context, index) {
                              final song = _favoriteSongs[index];
                              return _buildMusicItem(song);
                            })),
              ),
              const SongWidget(),
              NavigationWidget(
                currentIndex: 2, // Index của Library
                onTabSelected: (index) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MainScreen(initialPage: index)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Xây dựng một hàng hành động
  Widget _buildActionRow(IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              key: ValueKey<bool>(
                  _isFavorite), // Cập nhật trạng thái khi thay đổi
              color: icon == Icons.favorite
                  ? (_isFavorite ? Colors.red : Colors.grey)
                  : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Xây dựng một mục nhạc trong danh sách
  Widget _buildMusicItem(Map<String, dynamic> song) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white, // Màu nền trắng khi ảnh bị lỗi
                  image: DecorationImage(
                    image: NetworkImage(song['image'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song['name'] ?? 'Tên bài hát',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    song['artist'] ?? 'Ca sĩ',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: _showBottomSheet,
            icon: const Icon(
              Icons.more_vert_sharp,
              size: 24,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Xây dựng thông tin bài hát
  Widget _buildSongInfo() {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.network(
            "https://ls1.in/avEjH",
          ),
        ),
        const SizedBox(width: 8),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tên bài hát',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              'Ca sĩ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
