import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class MusicController extends GetxController {
  // Đối tượng AudioPlayer để phát nhạc
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Các theo dõi trạng thái và thông tin bài hát
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var duration = Duration.zero.obs;

  // Thông tin chi tiết của bài hát
  var id = "".obs;
  var coverImage = "cover_image".obs;
  var title = "title".obs;
  var artist = "artist".obs;
  var url = "url".obs;
  var album = "album".obs;
  var genre = "genre".obs;
  var lyrics = "lyrics".obs;
  var isFavorite = false.obs;

  // Danh sách và trạng thái playlist
  var songs = <Map<String, dynamic>>[].obs;
  var playlist = <Map<String, dynamic>>[].obs;
  var currentSongIndex = 0.obs;

  // Theo dõi URL và ID bài hát hiện tại
  RxString currentSongUrl = ''.obs;
  RxString currentSongId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Tải danh sách bài hát khi controller được khởi tạo
    fetchSongs();

    // Lắng nghe trạng thái phát nhạc
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    // Cập nhật vị trí và thời lượng bài hát
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });
    _audioPlayer.durationStream.listen((duration) {
      this.duration.value = duration ?? Duration.zero;
    });
  }

  // Lấy danh sách bài hát từ API
  Future<void> fetchSongs() async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Cập nhật danh sách bài hát và playlist
        songs.value = List<Map<String, dynamic>>.from(data);
        playlist.value = data.map((song) {
          return {
            'cover_image': song['cover_image'],
            'title': song['title'],
            'artist': song['artist'],
            'url': song['url'],
            'album': song['album'],
            'genre': song['genre'],
            'lyrics': song['lyrics'],
          };
        }).toList();

        // Nếu playlist không rỗng, phát bài đầu tiên
        if (playlist.isNotEmpty) {
          _updateSongInfo(0);
          await _audioPlayer.setUrl(playlist[0]['url']!);
        }
      } else {
        print('Lỗi tải bài hát: ${response.statusCode}');
      }
    } catch (e) {
      print("Lỗi tải bài hát: $e");
    }
  }

  // Kiểm tra và lấy trạng thái yêu thích của bài hát
  Future<void> getFavoriteStatus(String songId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Cập nhật trạng thái yêu thích
        if (data['isFavorite'] is bool) {
          isFavorite.value = data['isFavorite'];
        } else {
          throw Exception('Kiểu dữ liệu không hợp lệ cho isFavorite');
        }
      } else {
        throw Exception(
            'Không thể tải trạng thái yêu thích. Mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể tải trạng thái yêu thích: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Cập nhật trạng thái yêu thích của bài hát
  Future<void> updateFavoriteStatus(String songId) async {
    final currentStatus = isFavorite.value;
    isFavorite.value = !currentStatus;

    try {
      final response = await http.put(
        Uri.parse(
            'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId'),
        body: jsonEncode({'isFavorite': isFavorite.value}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final updatedData = jsonDecode(response.body);

        // Đồng bộ trạng thái từ phản hồi API
        if (updatedData['isFavorite'] is bool) {
          isFavorite.value = updatedData['isFavorite'];
        }

        // Tải lại danh sách bài hát sau khi cập nhật
        fetchSongs();
      } else {
        // Hoàn nguyên trạng thái nếu thất bại
        isFavorite.value = currentStatus;
      }
    } catch (e) {
      // Hoàn nguyên trạng thái nếu có lỗi
      isFavorite.value = currentStatus;
      Get.snackbar(
        'Lỗi',
        'Đã xảy ra lỗi: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Phát bài hát
  Future<void> playSong(String songId, String url) async {
    if (url.isEmpty) return;

    try {
      // Tạm dừng bài hát hiện tại nếu khác ID
      if (currentSongId.value.isNotEmpty && currentSongId.value != songId) {
        await _audioPlayer.pause();
        isPlaying.value = false;
      }

      // Cập nhật ID và URL bài hát
      currentSongId.value = songId;
      currentSongUrl.value = url;

      // Phát bài hát mới
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();

      // Cập nhật trạng thái phát
      isPlaying.value = true;
    } catch (e) {
      print("Lỗi khi phát nhạc: $e");
    }
  }

  // Chuyển đổi giữa phát và tạm dừng
  Future<void> togglePlayPause() async {
    if (playlist.isEmpty) {
      print("Danh sách phát trống");
      return;
    }
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
      } else {
        // Kiểm tra trạng thái AudioPlayer trước khi phát
        if (_audioPlayer.processingState != ProcessingState.ready) {
          await _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);
        }
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Lỗi khi chuyển đổi phát/tạm dừng: $e");
    }
  }

  // Chuyển đến bài tiếp theo
  void skipNext() async {
    if (playlist.isEmpty) {
      print("Danh sách phát trống");
      return;
    }

    try {
      // Cập nhật chỉ mục bài hát
      currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;

      // Phát bài hát tiếp theo
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);
      await _audioPlayer.play();

      // Cập nhật thông tin bài hát
      _updateSongInfo(currentSongIndex.value);
    } catch (e) {
      print("Lỗi khi chuyển bài tiếp theo: $e");
    }
  }

  // Quay lại bài hát trước
  void skipPrevious() async {
    if (playlist.isEmpty) {
      print("Danh sách phát trống");
      return;
    }

    try {
      // Cập nhật chỉ mục bài hát
      currentSongIndex.value =
          (currentSongIndex.value - 1 + playlist.length) % playlist.length;

      // Phát bài hát trước
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);
      await _audioPlayer.play();

      // Cập nhật thông tin bài hát
      _updateSongInfo(currentSongIndex.value);
    } catch (e) {
      print("Lỗi khi quay lại bài trước: $e");
    }
  }

  // Cập nhật thông tin bài hát
  void _updateSongInfo(int index) {
    coverImage.value = playlist[index]['cover_image'] ?? '';
    title.value = playlist[index]['title'] ?? 'Tên bài hát';
    artist.value = playlist[index]['artist'] ?? 'Nghệ sĩ';
    url.value = playlist[index]['url'] ?? '';
    album.value = playlist[index]['album'] ?? '';
    genre.value = playlist[index]['genre'] ?? '';
    lyrics.value = playlist[index]['lyrics'] ?? '';
    isFavorite.value = playlist[index]['isFavorite'] ?? false;
  }

  // Tua đến vị trí cụ thể trong bài hát
  void seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  // Định dạng thời gian
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void onClose() {
    // Giải phóng tài nguyên AudioPlayer khi controller bị hủy
    super.onClose();
    _audioPlayer.dispose();
  }
}
