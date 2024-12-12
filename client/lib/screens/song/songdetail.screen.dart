import 'package:client/widgets/playmusic.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/lycrics.widget.dart';
import 'package:get/get.dart';

class SongDetailScreen extends StatefulWidget {
  SongDetailScreen({super.key});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  final MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> song = Get.arguments;
    musicController.playSong(song['fileUrl']);

    musicController.fetchFavoriteStatus();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A1111), Color(0xFF150000)],
              stops: [0.3, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Thanh tiêu đề
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 42,
                      )),
                  const Expanded(
                    child: Column(
                      children: [
                        Text("ĐANG PHÁT TỪ TÌM KIẾM",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        Text("Lượt tìm kiếm gần đây",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white, size: 30),
                ],
              ),
              const SizedBox(height: 60),
              // Hình ảnh ca sĩ
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Bo góc
                ),
                child: Image.network(
                  (musicController.coverImage.value),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Hiển thị vòng xoay khi đang tải
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                        'https://picsum.photos/300/300'); // Ảnh mặc định nếu có lỗi
                  },
                ),
              ),
              const SizedBox(height: 60),
              // Tên bài hát
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(musicController.title.value,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          Text(musicController.artist.value,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 18)),
                        ]),
                    IconButton(
                        onPressed: () {
                          musicController.isFavorite.value =
                              !musicController.isFavorite.value;
                        },
                        icon: Icon(
                            musicController.isFavorite.value == true
                                ? Icons.add_circle_outline
                                : Icons.check_circle,
                            color: Colors.white,
                            size: 30))
                  ],
                );
              }),
              // Thanh chạy nhạc
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  return Slider(
                    value: musicController.currentPosition.value.inSeconds
                        .toDouble(),
                    min: 0,
                    max: musicController.duration.value.inSeconds.toDouble(),
                    activeColor: Colors.blueAccent,
                    inactiveColor: const Color.fromARGB(255, 255, 255, 255),
                    onChanged: (value) {
                      musicController.seekTo(Duration(seconds: value.toInt()));
                    },
                  );
                }),
              ),
              Obx(() {
                return Text(
                  '${musicController.formatDuration(musicController.currentPosition.value)} / ${musicController.formatDuration(musicController.duration.value)}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                );
              }),
              const SizedBox(height: 20),
              // Thanh công cụ nhạc
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.shuffle, color: Colors.white, size: 30),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      musicController
                          .skipPrevious(); // Gọi phương thức để chuyển bài hát
                    },
                    child: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(width: 20),
                  // Dừng và phát nhạc
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        musicController.togglePlayPause();
                      },
                      child: Icon(
                        musicController.isPlaying.value
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.white,
                        size: 70,
                      ),
                    );
                  }),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      musicController
                          .skipNext(); // Gọi phương thức để chuyển bài hát
                    },
                    child: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(Icons.refresh, color: Colors.white, size: 30),
                ],
              ),
              const SizedBox(height: 20),
              // Kết nối chia sẻ
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.edgesensor_high_outlined,
                      color: Colors.white, size: 25),
                  Row(
                    children: [
                      Icon(Icons.share_outlined, color: Colors.white, size: 25),
                      SizedBox(width: 20),
                      Icon(Icons.list_alt_sharp, color: Colors.white, size: 25),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Hiển thị ngắn bài hát
              Container(
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff4e4e6e),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bản xem trước bài hát",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        musicController.lyrics.value,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Lyrics()));
                      },
                      child: const Text(
                        "Hiện lời bài hát",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Giới thiệu nghệ sĩ
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        "https://cdn.pixabay.com/photo/2015/02/21/20/05/dj-644557_640.jpg",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sơn Tùng M-TP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                Text('1,7 Tr người nghe hàng tháng',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 16)),
                                SizedBox(height: 8),
                                Text(
                                  'Nguyễn Thanh Tùng, born in 1994, known professionally as Sơn Tùng M-TP, is a Vietnamese singer, songwriter, producer, and actor. He is not only ...',
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                            ),
                            onPressed: () {},
                            child: const Text("Theo dõi",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Khám phá tác giả
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Khám phá Đoàn Lâm",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 240,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2024/01/31/12/08/dj-8543998_640.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Các bài hát của Đoàn Lâm",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                  Text("Đoàn Lâm",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 240,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2023/03/16/16/31/music-7857068_640.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Tương tự như Trưởng Thành Không Vui",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 240,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2024/01/31/12/08/dj-8543998_640.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Các bài hát nổi bật",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Người tham gia thực hiện
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Tiêu đề phần "Người tham gia thực hiện"
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Người tham gia thực hiện",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        Text(
                          "Hiện tất cả",
                          style: TextStyle(
                            color: Color(0xff009e00),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Danh sách người tham gia
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Đoàn Lâm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Đoàn Lâm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Nghệ sĩ chính, Người viết lời",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Theo dõi",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // CT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Nghệ sĩ chính",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Theo dõi",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Nhạc Hoa Lời Việt
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nhạc Hoa Lời Việt",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Nhà soạn nhạc",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
