import 'package:client/main.dart';
import 'package:client/screens/song/songdetail.screen.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> songs = [];
  List<Map<String, dynamic>> artists = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSongs();
    fetchArtists();
  }

  Future<void> fetchSongs() async {
    try {
      final response = await Dio().get('http://localhost:3000/api/v1/song');
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          songs = List<Map<String, dynamic>>.from(response.data['data']);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching songs: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchArtists() async {
    try {
      final response = await Dio().get('http://localhost:3000/api/v1/artist');
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          artists = List<Map<String, dynamic>>.from(response.data['data']);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching songs: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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

            // GridView - Thành phần mới
            SizedBox(
              height:
                  256, // Chiều cao phù hợp với 2 dòng (mỗi dòng 50px + khoảng cách)
              child: GridView.builder(
                itemCount: songs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 50,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return GestureDetector(
                    onTap: () {
                      // Chuyển sang trang chi tiết bài hát khi click
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongDetailScreen(),
                          settings: RouteSettings(
                            arguments: song,
                          ),
                        ),
                      );
                    },
                    child: GridItem(
                      title: song['title'] ?? 'Unknown',
                      subtitle: song['artist']['name'] ?? 'Unknown Artist',
                      imageUrl: Uri.decodeFull(song['coverImageUrl']),
                    ),
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
                    aspectRatio: 16 /
                        9, // Tỷ lệ chuẩn (hoặc thay bằng tỷ lệ của hình ảnh thực tế)
                    child: Image.asset(
                      "assets/images/wrapped_banner.jpg",
                      fit: BoxFit
                          .cover, // Bao phủ toàn bộ không gian mà vẫn giữ tỷ lệ
                      width: double
                          .infinity, // Tự động theo chiều rộng của thiết bị
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
                children: const [
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
                  child: isLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator()) // Hiển thị loading khi đang tải
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: artists.length, // Số lượng nghệ sĩ
                          itemBuilder: (context, index) {
                            final artist = artists[index]; // Dữ liệu nghệ sĩ
                            return RecentItem(
                              title: artist['name'] ?? 'Unknown Artist',
                              subtitle: artist['bio'] ?? 'Artist',
                              imageUrl: artist['avatarUrl'] ??
                                  'assets/images/default.jpg',
                            );
                          },
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
                children: const [
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
                children: const [
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
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SongWidget(),
              NavigationWidget(
                currentIndex: 0,
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
        ));
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
            child: Image.network(
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
                backgroundImage: NetworkImage(imageUrl),
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
