import 'package:client/main.dart';
import 'package:client/screens/playlist/playlist.create.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Điều khiển hoạt động của animation.
  late Animation<Offset>
      _offsetAnimation; // Xác định hướng và chuyển động cho SlideTransition.
  late OverlayEntry _overlayEntry; // Tạo lớp overlay để hiển thị menu trượt.

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController.
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 200), // Thời gian chạy animation (200ms).
      vsync:
          this, // Đồng bộ với khung hình hiện tại, giúp tiết kiệm tài nguyên.
    );

    // Khởi tạo animation cho SlideTransition.
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Bắt đầu từ ngoài màn hình bên trái.
      end: Offset.zero, // Kết thúc ở giữa màn hình.
    ).animate(CurvedAnimation(
      parent: _controller, // Gắn với AnimationController để kiểm soát.
      curve: Curves.easeInOut, // Tạo hiệu ứng mượt khi bắt đầu và kết thúc.
    ));
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Giải phóng AnimationController khi không còn cần thiết.
    super.dispose();
  }

  // Hiển thị menu trượt bằng OverlayEntry.
  void _showSlideMenu() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        width: MediaQuery.of(context).size.width *
            0.9, // Chiếm 90% chiều rộng màn hình.
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx < -10) {
              // Nếu lướt nhanh sang trái, ẩn menu.
              _hideSlideMenu();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: SlideTransition(
              position: _offsetAnimation, // Gắn animation đã khởi tạo.
              child: Container(
                color: const Color.fromARGB(
                    255, 33, 33, 33), // Màu nền menu trượt.
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _showSlideMenu, // Mở menu trượt khi nhấn.
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                "https://ls1.in/avEjH", // Ảnh đại diện.
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Xem chi tiết hồ sơ
                          GestureDetector(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                _hideSlideMenu();
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, '/user-profile');
                              });
                            },
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tên người dùng ", // Tên
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Xem hồ sơ", // Tiêu đề chính.
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Đường gạch dưới
                    const Divider(
                      color: Colors.grey, // Màu sắc của đường viền
                      height: 20, // Chiều cao của divider
                      thickness: .2, // Độ dày của đường viền
                    ),
                    // Thanh menu user
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("sign-up");
                          }, // Mở menu khi nhấn.
                          child: const Row(
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 36),
                              SizedBox(width: 20),
                              Text(
                                "Thêm tài khoản",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry); // Thêm overlay vào màn hình.
    _controller.forward(); // Kích hoạt animation để hiện menu.
  }

  // Ẩn menu trượt và xóa overlay.
  void _hideSlideMenu() {
    _controller.reverse().then((_) {
      // Kích hoạt animation đóng.
      _overlayEntry.remove(); // Xóa overlay sau khi animation kết thúc.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Màu nền chính.
      body: Stack(
        children: [
          // Nền gradient chính.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 37, 4, 78),
                  Colors.black
                ], // Màu chuyển từ tím sang đen.
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với hình ảnh và các nút.
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _showSlideMenu, // Mở menu trượt khi nhấn.
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                "https://ls1.in/avEjH", // Ảnh đại diện.
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Thư Viện", // Tiêu đề chính.
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen(
                                            initialPage: 1,
                                          )));
                            }, // Tính năng tìm kiếm.
                            icon: const Icon(Icons.search,
                                color: Colors.grey, size: 40),
                          ),
                          IconButton(
                            onPressed: _showAddMenu, // Hiển thị menu thêm.
                            icon: const Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Danh sách thư viện.
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildLibraryItem(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI6f-ExylkpwX5V7FbtITtoiJyWk-8-jfKB-O1BBz_2fPEOg6a_ywGHfZaIvFdlDvCNfY&usqp=CAU", // Ảnh mục thư viện.
                        text: "Bài hát đã thích", // Tiêu đề mục.
                        onTap: () {
                          Get.toNamed('/favorite-list');
                        },
                      ),
                      _buildLibraryItem(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPChQuJDe64C1DKFYOHxobWZjX9PPQtWWX5LYXvgtto9_M2NL4bXWlNnQqsHzxvmjHX0c&usqp=CAU",
                        text: "Album",
                        onTap: () {
                          Get.toNamed('/album');
                        },
                      ),
                      _buildLibraryItem(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/512/636/636224.png",
                        text: "Playlist của tôi",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo mục thư viện.
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
            CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(imageUrl),
            ),

            const SizedBox(width: 16),
            Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold)), // Hiển thị tên mục.
          ],
        ),
      ),
    );
  }

  // Hàm hiển thị menu thêm danh sách phát.
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
            color: Color.fromARGB(255, 24, 24, 24), // Màu nền menu.
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListTile(
            leading: const Icon(Icons.playlist_add,
                color: Colors.white), // Icon thêm danh sách phát.
            title: const Text(
              "Danh sách phát",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context); // Đóng menu hiện tại.
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
