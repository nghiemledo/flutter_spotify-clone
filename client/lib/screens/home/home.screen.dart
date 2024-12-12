import 'package:client/controller/album.controller.dart';
import 'package:client/screens/album/album.screen.dart';
import 'package:client/controller/playmusic.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final MusicController musicController = Get.put(MusicController());
  final AlbumController albumController = Get.put(AlbumController());
  // final Api api = Get.put(Api());

  HomeScreen({super.key});
  final List<Map<String, dynamic>> playlist = [];

  @override
  Widget build(BuildContext context) {
    musicController.fetchSongs();
    musicController.fetchAlbums();
    // api.fetchAlbums();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "09:27",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Filters với khả năng cuộn ngang
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(width: 10),
                FilterChip(label: "All", isActive: true),
                SizedBox(width: 10),
                FilterChip(label: "Wrapped"),
                SizedBox(width: 10),
                FilterChip(label: "Music"),
                SizedBox(width: 10),
                FilterChip(label: "Podcasts"),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // GridView
          SizedBox(
            height: 256,
            child: GridView.builder(
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 50,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final items = [
                  {
                    "title": "G-DRAGON",
                    "subtitle": "Artist",
                    "image": "assets/images/artist4.jpg"
                  },
                  {
                    "title": "Bạn Đời",
                    "subtitle": "Album - Karik",
                    "image": "assets/images/album.jpg"
                  },
                ];

                return GridItem(
                  title: items[index]["title"]!,
                  subtitle: items[index]["subtitle"]!,
                  imageUrl: items[index]["image"]!,
                );
              },
            ),
          ),

          // Banner
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    "assets/images/wrapped_banner.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Your Top Mixes
          const SectionTitle(title: "Your top mixes"),
          const SizedBox(height: 8),
          Obx(() {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: musicController.playlist.length,
                itemBuilder: (context, index) {
                  final album = musicController.playlist[index];
                  return GestureDetector(
                    onTap: () {
                      albumController.setAlbum(album);

                      // Điều hướng đến màn hình chi tiết album
                      Get.to(() =>
                          AlbumScreen()); // Sử dụng Get.to() để điều hướngchi tiết
                    },
                    child: MixCard(
                      title: album['name'] ?? "Unknown Title",
                      subtitle: album['artist'] ?? "Unknown Artist",
                      imageUrl: album['coverImageUrl'] ??
                          "assets/images/placeholder.jpg",
                    ),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 16),

          // Recents
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionTitle(title: "Recents"),
                  Text("Show all", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    RecentItem(
                      title: "G-DRAGON",
                      subtitle: "Artist",
                      imageUrl: "assets/images/artist4.jpg",
                    ),
                    RecentItem(
                      title: "Liked Songs",
                      subtitle: "3 songs added",
                      imageUrl: "assets/images/liked_songs.jpg",
                      hasBadge: true,
                    ),
                    RecentItem(
                      title: "Bạn Đời",
                      subtitle: "Album - Karik",
                      imageUrl: "assets/images/album.jpg",
                    ),
                    RecentItem(
                      title: "New Song",
                      subtitle: "Album - Sơn Tùng",
                      imageUrl: "assets/images/new_song.jpg",
                    ),
                    RecentItem(
                      title: "Hits",
                      subtitle: "Playlist",
                      imageUrl: "assets/images/playlist.jpg",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Songs List
          Obx(() {
            if (musicController.songs.isEmpty) {
              return const Center(
                  child: Text(
                "No songs available",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ));
            }
            return ListView.builder(
              shrinkWrap:
                  true, // Giảm kích thước để phù hợp với phần còn lại của màn hình
              itemCount: musicController.songs.length,
              itemBuilder: (context, index) {
                final song = musicController.songs[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // Ảnh nền
                      SizedBox(
                        width: double.infinity,
                        height: 350, // Chiều cao của ảnh nền
                        child: Image.network(
                          song['coverImageUrl'],
                          fit: BoxFit.cover, // Ảnh sẽ bao phủ toàn bộ diện tích
                        ),
                      ),

                      // Ảnh nhỏ ở góc trên bên trái (hình vuông bo góc)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(8), // Bo góc cho ảnh nhỏ
                          child: Image.network(
                            song[
                                'coverImageUrl'], // Dùng ảnh từ bài hát hoặc một ảnh khác
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Tên bài hát và tên tác giả ngang hàng với ảnh nhỏ
                      Positioned(
                        top: 10,
                        left: 70, // Đặt một khoảng cách để tránh che ảnh nhỏ
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              song['artist'],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Nút yêu thích (ở góc trên bên phải)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            song['isFavorite'] ? Icons.favorite : Icons.add,
                            color:
                                song['isFavorite'] ? Colors.red : Colors.white,
                            size: 40, // Tăng kích thước nút yêu thích
                          ),
                          onPressed: () {
                            musicController.updateFavoriteStatus(song['_id']);
                            // api.updateFavoriteStatus(song['_id']);
                          },
                        ),
                      ),

                      // Nút Play ở góc dưới bên phải
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Obx(() => IconButton(
                              onPressed: () {
                                // Gọi phương thức playSong để phát bài hát mới
                                musicController.playSong(
                                    song['_id'], song['fileUrl']);
                              },
                              icon: Icon(
                                musicController.currentSongId.value ==
                                        song['_id']
                                    ? (musicController.isPlaying.value
                                        ? Icons.pause
                                        : Icons.play_arrow)
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

// Các Widget Hỗ Trợ
class GridItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const GridItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 40, // Chiều cao ảnh
              width: 40, // Chiều rộng ảnh
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const FilterChip({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: isActive ? Colors.black : Colors.white),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class MixCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  const MixCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text(subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class RecentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool hasBadge;

  const RecentItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 80,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imageUrl),
              ),
              if (hasBadge)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class StationCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  const StationCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: Column(
        children: [
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text(artist,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class JumpBackCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  const JumpBackCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: Column(
        children: [
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
