import 'dart:convert';
import 'package:client/main.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/playmusic.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Màn hình danh sách bài hát yêu thích
class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Tạo gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 37, 4, 78), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 1.0],
          ),
        ),
        child: SafeArea(
          // Sử dụng GetX để reactive state management
          child: GetX<FavoriteController>(
            // Khởi tạo controller
            init: FavoriteController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nút quay lại
                  _buildBackButton(),

                  // Tiêu đề và số lượng bài hát
                  _buildScreenHeader(controller.favoriteSongs.length),

                  // Các nút điều khiển phát nhạc
                  _buildPlayControls(),

                  // Danh sách các bài hát yêu thích
                  _buildFavoriteSongsList(controller),

                  // Widget thanh phát nhạc
                  const SongWidget(),

                  // Widget điều hướng
                  NavigationWidget(
                    currentIndex: 2,
                    onTabSelected: (index) {
                      // Chuyển đến màn hình chính với tab được chọn
                      Get.offAll(() => MainScreen(initialPage: index));
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // nút quay lại
  Widget _buildBackButton() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        size: 28,
        color: Colors.white,
      ),
      // Sử dụng Get.back() để quay lại màn hình trước
      onPressed: () => Get.back(),
    );
  }

  // tiêu đề màn hình và số lượng bài hát
  Widget _buildScreenHeader(int songCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề "Bài hát đã thích"
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
        // Hiển thị số lượng bài hát
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '$songCount bài hát',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  // các nút điều khiển phát nhạc
  Widget _buildPlayControls() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút tải xuống
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.download_for_offline_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Row(
            children: [
              // Nút phát nhạc
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.play_circle,
                  color: Colors.green,
                  size: 55,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // danh sách các bài hát yêu thích
  Widget _buildFavoriteSongsList(FavoriteController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Hiển thị loading indicator khi đang tải dữ liệu
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.favoriteSongs.length,
                itemBuilder: (context, index) {
                  final song = controller.favoriteSongs[index];
                  return _buildMusicItem(song);
                },
              ),
      ),
    );
  }

  // item bài hát trong danh sách
  Widget _buildMusicItem(Map<String, dynamic> song) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        // Chuyển đến chi tiết bài hát khi nhấn
        onTap: () => navigateToSongDetail(song),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Thông tin bài hát
            _buildSongInfo(song),
            // Nút thêm tùy chọn
            _buildMoreOptionsButton(song),
          ],
        ),
      ),
    );
  }

  // Chuyển đến màn hình chi tiết bài hát
  void navigateToSongDetail(Map<String, dynamic> song) {
    final MusicController musicController = Get.find();

    // Cập nhật dữ liệu vào MusicController
    musicController.coverImage.value = song['cover_image'] ?? '';
    musicController.title.value = song['title'] ?? 'Chưa có tiêu đề';
    musicController.artist.value = song['artist'] ?? 'N/A';
    musicController.url.value = song['url'] ?? '';
    musicController.album.value = song['album'] ?? '';
    musicController.genre.value = song['genre'] ?? '';
    musicController.lyrics.value = song['lyrics'] ?? '';

    musicController.togglePlayPause();
    // Chuyển hướng đến màn hình chi tiết
    Get.toNamed('/song-detail', arguments: song);
  }

  // thông tin bài hát (ảnh bìa, tên bài hát, ca sĩ)
  Widget _buildSongInfo(Map<String, dynamic> song) {
    return Row(
      children: [
        // Ảnh bìa bài hát
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              // Sử dụng ảnh từ URL hoặc ảnh placeholder
              image: NetworkImage(
                  song['cover_image'] ?? 'https://picsum.photos/80/80'),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.network(
            song['cover_image'] ?? 'https://picsum.photos/80/80',
            fit: BoxFit.cover,
            // Xử lý lỗi khi không tải được ảnh
            errorBuilder: (context, error, stackTrace) {
              return Image.network('https://picsum.photos/80/80');
            },
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên bài hát
            Text(
              song['title'] ?? 'Tên bài hát',
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            // Tên ca sĩ
            Text(
              song['artist'] ?? 'Ca sĩ',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  // nút hiển thị thêm tùy chọn
  Widget _buildMoreOptionsButton(Map<String, dynamic> song) {
    return IconButton(
      // Hiển thị bottom sheet khi nhấn
      onPressed: () => _showBottomSheet(song),
      icon: const Icon(
        Icons.more_vert_sharp,
        size: 24,
        color: Colors.grey,
      ),
    );
  }

  // Hiển thị bottom sheet
  void _showBottomSheet(Map<String, dynamic> song) {
    Get.bottomSheet(
      // Nội dung bottom sheet
      _buildBottomSheetContent(song),
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // nội dung bottom sheet
  Widget _buildBottomSheetContent(Map<String, dynamic> song) {
    final controller = Get.find<FavoriteController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 500,
        child: Wrap(
          children: [
            // Thanh điều khiển bottom sheet
            const Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.remove,
                color: Colors.grey,
                size: 40,
              ),
            ),
            // Thông tin bài hát
            _buildSongInfo(song),
            const Divider(color: Colors.grey),
            const SizedBox(height: 32),
            // Nút thêm/xóa yêu thích
            Row(
              children: [
                // Biểu tượng trái tim
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.favorite,
                    color: song['isFavorite'] ? Colors.red : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                // Nút thêm/xóa khỏi danh sách yêu thích
                GestureDetector(
                  onTap: () => controller.toggleFavorite(song),
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
            const SizedBox(height: 32),
            // Các hành động khác
            Column(
              children: [
                _buildActionRow(Icons.add, "Thêm vào danh sách phát", () {}),
                _buildActionRow(Icons.album, "Đến album", () {}),
                _buildActionRow(Icons.person, "Đến nghệ sĩ", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // hành động trong bottom sheet
  Widget _buildActionRow(IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
}

class FavoriteController extends GetxController {
  final RxList<dynamic> favoriteSongs = <dynamic>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteSongs();
  }

  Future<void> fetchFavoriteSongs() async {
    try {
      final url = Uri.parse(
          'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        favoriteSongs.value =
            data.where((song) => song['isFavorite'] == true).toList();
      } else {
        print('Failed to load favorite songs');
      }
    } catch (e) {
      print('Error fetching songs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(Map<String, dynamic> song) async {
    final songId = song['id'];
    final currentFavoriteStatus = song['isFavorite'];

    try {
      // Cập nhật trạng thái yêu thích trước khi gọi API
      final index = favoriteSongs.indexWhere((s) => s['id'] == songId);
      if (index != -1) {
        favoriteSongs[index]['isFavorite'] = !currentFavoriteStatus;
      }

      // Thực hiện gọi API để thay đổi trạng thái yêu thích
      final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId',
      );

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isFavorite': !currentFavoriteStatus}),
      );

      if (response.statusCode == 200) {
        // Sau khi thay đổi trạng thái trên server, refetch lại danh sách yêu thích
        await fetchFavoriteSongs();
      } else {
        print('Failed to update favorite status: ${response.body}');
      }
    } catch (e) {
      print('Error updating favorite: $e');
    }
  }
}
