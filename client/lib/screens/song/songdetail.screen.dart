import 'package:client/widgets/lycrics.widget.dart';
import 'package:flutter/material.dart';

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              //Thanh tiêu đề
              const Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.white, size: 30)),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Text("ĐANG PHÁT TỪ TÌM KIẾM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            )),
                        Text("Lượt tìm kiếm gần đây",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:
                          Icon(Icons.more_vert, color: Colors.white, size: 30))
                ],
              ),
              const SizedBox(height: 60),
              // Hình ảnh ca sĩ
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      height: 370,
                      fit: BoxFit.cover,
                      "data:image/jpeg;base64,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")),
              const SizedBox(height: 60),
              // Tên bài hát
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Trưởng Thành Không Vui",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("Đoàn Lâm,CT",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ))
                      ]),
                  Icon(Icons.add_circle_outline, color: Colors.white, size: 30)
                ],
              ),
              // Thanh chạy nhạc
              Slider(
                  value: 71,
                  min: 0,
                  max: 283,
                  activeColor: Colors.white,
                  inactiveColor: const Color(0xFF272727),
                  onChanged: (value) {}),
              // Số liệu chạy nhạc
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1:11",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      )),
                  Text("4:43",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ))
                ],
              ),
              const SizedBox(height: 20),
              // Thanh công cụ nhạc
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.shuffle, color: Colors.white, size: 30),
                    Icon(Icons.skip_previous, color: Colors.white, size: 55),
                    Icon(Icons.play_circle, color: Colors.white, size: 70),
                    Icon(Icons.skip_next, color: Colors.white, size: 55),
                    Icon(Icons.refresh, color: Colors.white, size: 30),
                  ]),
              const SizedBox(height: 20),
              // Kết nối chia sẻ
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.edgesensor_high_outlined,
                        color: Colors.white, size: 25),
                    Row(
                      children: [
                        Icon(Icons.share_outlined,
                            color: Colors.white, size: 25),
                        SizedBox(width: 20),
                        Icon(Icons.list_alt_sharp,
                            color: Colors.white, size: 25),
                      ],
                    )
                  ]),
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
                          fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 20),
                    // Lời bài hát hiển thị
                    const Expanded(
                      child: Text("Biết em thương người ấy đã rất nhiều ",
                          style: TextStyle(color: Colors.white, fontSize: 25)
                      )
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Lyrics()),
                        );
                      },
                      child: const Text("Hiện lời bài hát",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Gioi thiệu nghệ sĩ
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                          // Column chứa thông tin nghệ sĩ
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sơn Tùng M-TP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '1,7 Tr người nghe hàng tháng',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Nguyễn Thanh Tùng, born in 1994, known professionally as Sơn Tùng M-TP, is a Vietnamese singer, songwriter, producer, and actor. He is not only ...',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 14,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // OutlinedButton ở phía bên phải
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Theo dõi",
                              style: TextStyle(color: Colors.white),
                            ),
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
                        fontWeight: FontWeight.bold,
                      ),
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
                                  Text(
                                    "Các bài hát của Đoàn Lâm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "Đoàn Lâm",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
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
                                  Text(
                                    "Tương tự như Trưởng Thành Không Vui",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
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
                                  Text(
                                    "Tương tự như Trưởng Thành Không Vui",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
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
                        // SizedBox(width: 5),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
