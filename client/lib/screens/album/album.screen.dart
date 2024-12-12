import 'package:client/controller/album.controller.dart';
import 'package:client/main.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/controller/playmusic.controller.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AlbumScreen extends StatelessWidget {
  MusicController musicController = Get.put(MusicController());
  AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AlbumController albumController = Get.find(); // Lấy albumController

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, albumController),
            _buildSongList(albumController),
            const SizedBox(height: 30),
            _buildOtherAlbumsSection(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SongWidget(),
            NavigationWidget(
              currentIndex: 2,
              onTabSelected: (index) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(initialPage: index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AlbumController albumController) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(albumController.album['coverImageUrl'] ??
              'https://via.placeholder.com/150'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Album',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  albumController.album['name'] ?? 'Album Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${albumController.album['artist'] ?? 'Artist'} • 2020 • 4 bài hát',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Phát'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Thay đổi: Truyền albumController trực tiếp, không phải Map<String, dynamic> nữa
  Widget _buildSongList(AlbumController albumController) {
    List<dynamic> songs = albumController.album['songs'] ??
        []; // Lấy danh sách bài hát từ albumController

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: songs.map((song) {
          return _buildSongItem(
              song); // Gọi hàm _buildSongItem để tạo item cho mỗi bài hát
        }).toList(),
      ),
    );
  }

  // Sửa lại hàm này để phù hợp với dữ liệu bài hát
  Widget _buildSongItem(Map<String, dynamic> song) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          navigateToSongDetail(song);
        },
        child: Row(
          children: [
            Image.network(song['coverImageUrl'], width: 50, height: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    song['artist'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_sharp, color: Colors.white),
              onPressed: () {
                // Phát nhạc từ URL của bài hát
                print('Đang phát: ${song['_id']}');
                musicController.playSong(song['_id'], song['fileUrl']);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherAlbumsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Các album khác của Sơn Tùng M-TP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Image.network(
                'https://images.pexels.com/photos/5941318/pexels-photo-5941318.jpeg',
                height: 200,
                width: 150,
                fit: BoxFit.cover,
              ),
              const Column(
                children: [
                  Text('MTP-album-2018'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Chuyển đến màn hình chi tiết bài hát
void navigateToSongDetail(Map<String, dynamic> song) {
  final MusicController musicController = Get.find();

  // Cập nhật dữ liệu vào MusicController
  musicController.id.value = song['_id'] ?? '';
  musicController.coverImage.value = song['coverImageUrl'] ?? '';
  musicController.title.value = song['title'] ?? 'Chưa có tiêu đề';
  musicController.artist.value = song['artist'] ?? 'N/A';
  musicController.fileUrl.value = song['fileUrl'] ?? '';
  musicController.album.value = song['album'] ?? '';
  musicController.genre.value = song['genre'] ?? '';
  musicController.lyrics.value = song['lyrics'] ?? '';

  musicController.togglePlayPause();
  // Chuyển hướng đến màn hình chi tiết
  Get.toNamed('/song-detail', arguments: song);
}
