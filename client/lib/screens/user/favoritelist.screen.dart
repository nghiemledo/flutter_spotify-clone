import 'dart:convert';

import 'package:client/main.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  // danh sách nhạc yêu thích
  List<dynamic> _favoriteSongs = [];

// Hàm fetch dữ liệu từ API
  Future<void> _fetchFavoriteSongs() async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _favoriteSongs =
              data.where((song) => song['isFavorite'] == true).toList();
        });
      } else {
        print('Failed to load favorite songs');
      }
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

// Hàm update Yêu thích
  Future<void> _updateFavoriteSongs(String songId, bool isFavorie) async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isFavorite': isFavorie}),
      );
      if (response.statusCode == 200) {
        print('Favorite status updated successfully');
      } else {
        print('Failed to update favorite status: ${response.body}');
      }
    } catch (e) {
      print('Error $e');
    }
  }

  // Thay đổi trạng thái yêu thích
  void _toggleFavorite(Map<String, dynamic> song) {
    setState(() {
      song['isFavorite'] = !song['isFavorite'];
    });
    _updateFavoriteSongs(song['id'], song['isFavorite']);
  }

  @override
  void initState() {
    super.initState();
    _fetchFavoriteSongs(); // Gọi API khi khởi tạo
  }

  // Hàm mở Bottom Sheet
  void _showBottomSheet(Map<String, dynamic> song) {
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
                _buildSongInfo(song),
                const Divider(color: Colors.grey),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.favorite,
                            color:
                                song['isFavorite'] ? Colors.red : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            _toggleFavorite(song); // Gọi hàm xử lý
                          },
                          child: Text(
                            song['isFavorite']
                                ? "Xóa khỏi danh sách yêu thích"
                                : "Thêm vào danh sách yêu thích",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
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
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${_favoriteSongs.length} bài hát',
                  style: const TextStyle(
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

  // Đường dẫn đến album ,ca sĩ
  Widget _buildActionRow(IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              color: Colors.grey,
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

  //  danh sách nhạc yêu thích
  Widget _buildMusicItem(Map<String, dynamic> song) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          // Truyền dữ liệu sang màn hình song-detail
          Get.toNamed('/song-detail', arguments: {
            'id': song['id'] ?? '',
            'title': song['title'] ?? 'Chưa có tiêu đề',
            'artist': song['artist'] ?? 'N/A',
            'coverImageUrl': song['coverImageUrl'],
            'fileUrl': song['fileUrl'] ?? '',
            'isFavorite': song['isFavorite'] ?? false,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(song['corverImageUrl'] ??
                          'https://picsum.photos/80/80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Image.network(
                    song['corverImageUrl'] ?? 'https://picsum.photos/80/80',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                          'https://picsum.photos/80/80'); // Ảnh mặc định
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song['title'] ?? 'Tên bài hát',
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
              onPressed: () => _showBottomSheet(song),
              icon: const Icon(
                Icons.more_vert_sharp,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // thông tin bài hát trong showBottom
  Widget _buildSongInfo(song) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.network(
            song['coverImageUrl'] ??
                'https://picsum.photos/80/80', // Ảnh mặc định
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                  'https://picsum.photos/80/80'); // Ảnh mặc định
            },
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song['title'],
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              song['artist'],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
