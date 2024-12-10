import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                const SizedBox(width: 10),
                FilterChip(label: "All", isActive: true),
                const SizedBox(width: 10),
                FilterChip(label: "Wrapped"),
                const SizedBox(width: 10),
                FilterChip(label: "Music"),
                const SizedBox(width: 10),
                FilterChip(label: "Podcasts"),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // GridView - Thành phần mới
          SizedBox(
            height:
                256, // Chiều cao phù hợp với 2 dòng (mỗi dòng 50px + khoảng cách)
            child: GridView.builder(
              itemCount: 8, // Tổng số phần tử trong GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cột
                crossAxisSpacing: 8, // Khoảng cách ngang giữa các cột
                mainAxisSpacing: 8, // Khoảng cách dọc giữa các hàng
                mainAxisExtent: 50, // Chiều cao mỗi ô là 50px
              ),
              physics: const NeverScrollableScrollPhysics(), // Tắt cuộn độc lập
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
                  {
                    "title": "Live Concert",
                    "subtitle": "Concert",
                    "image": "assets/images/concert.jpg"
                  },
                  {
                    "title": "Soul Of The Forest",
                    "subtitle": "Album",
                    "image": "assets/images/forest.jpg"
                  },
                  {
                    "title": "Rất Lâu Rồi Mới Khóc",
                    "subtitle": "Live Version",
                    "image": "assets/images/live_song.jpg"
                  },
                  {
                    "title": "Liked Songs",
                    "subtitle": "3 songs added",
                    "image": "assets/images/liked_songs.jpg"
                  },
                  {
                    "title": "Có Một Nơi Như Thế",
                    "subtitle": "Single",
                    "image": "assets/images/single.jpg"
                  },
                  {
                    "title": "The Masked Singer",
                    "subtitle": "Live Show",
                    "image": "assets/images/masked_singer.jpg"
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
            onTap: () {
              // Hành động khi nhấn vào
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 /
                      9, // Tỷ lệ chuẩn (hoặc thay bằng tỷ lệ của hình ảnh thực tế)
                  child: Image.asset(
                    "assets/images/wrapped_banner.jpg",
                    fit: BoxFit
                        .cover, // Bao phủ toàn bộ không gian mà vẫn giữ tỷ lệ
                    width:
                        double.infinity, // Tự động theo chiều rộng của thiết bị
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          //end moi

          // Your Top Mixes
          const SectionTitle(title: "Your top mixes"),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MixCard(
                  title: "Quốc Thiên Mix",
                  subtitle: "Bằng Kiều, Đình Tiến Đạt",
                  imageUrl: "assets/images/artist1.jpg",
                ),
                MixCard(
                  title: "Karik Mix",
                  subtitle: "Da LAB, SOOBIN",
                  imageUrl: "assets/images/artist2.jpg",
                ),
                MixCard(
                  title: "Hip-hop Mix",
                  subtitle: "Andrew Gold",
                  imageUrl: "assets/images/artist3.jpg",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recents
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SectionTitle(title: "Recents"),
                  Text("Show all", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
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

          // Recommended Stations
          const SectionTitle(title: "Recommended Stations"),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                StationCard(
                  title: "Bạn Đời",
                  artist: "Karik, GDucky",
                  imageUrl: "assets/images/album2.jpg",
                ),
                StationCard(
                  title: "Pop Hits",
                  artist: "Various Artists",
                  imageUrl: "assets/images/album3.jpg",
                ),
                StationCard(
                  title: "Acoustic Vibes",
                  artist: "Various Artists",
                  imageUrl: "assets/images/album4.jpg",
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // Jump Back In
          const SectionTitle(title: "Jump back in"),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                JumpBackCard(
                  title: "Voi bạn đơn",
                  subtitle: "Playlist",
                  imageUrl: "assets/images/jump_back_1.jpg",
                ),
                JumpBackCard(
                  title: "Chill Mix",
                  subtitle: "HIEUTHUHAI, Karik, Jack - J97 and more",
                  imageUrl: "assets/images/jump_back_2.jpg",
                ),
                JumpBackCard(
                  title: "Đôi Tư",
                  subtitle: "Single - Andree",
                  imageUrl: "assets/images/jump_back_3.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.library_music), label: "Your Library"),
      //   ],
      // ),
    );
  }
}

// Các Widget Hỗ Trợ
class GridItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const GridItem({
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
  const FilterChip({required this.label, this.isActive = false});

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
  const SectionTitle({required this.title});

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
      {required this.title, required this.subtitle, required this.imageUrl});

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
      {required this.title, required this.artist, required this.imageUrl});

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
