import 'dart:convert';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Khởi tạo đối tượng AudioPlayer
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs; // Thời gian hiện tại của bài hát
  var duration = Duration.zero.obs; // Tổng thời gian của bài hát
  var coverImage = "coverImageUrl".obs;
  var title = "title".obs;
  var artist = "artist".obs;
  var fileUrl = "fileUrl".obs;
  var album = "album".obs;
  var genre = "genre".obs;
  var lyrics = "lyrics".obs;
  var isFavorite = false.obs;

  // Giả lập API service
  Future<void> fetchFavoriteStatus() async {
    try {
      // Gọi API để lấy trạng thái yêu thích
      await Future.delayed(const Duration(seconds: 1)); // Giả lập độ trễ API
      isFavorite.value = true; // Trạng thái giả sử trả về từ API
    } catch (e) {
      print("Lỗi khi lấy trạng thái: $e");
    }
  }

  Future<void> updateFavoriteStatus() async {
    try {
      // Cập nhật trạng thái yêu thích lên API
      await Future.delayed(
          const Duration(milliseconds: 500)); // Giả lập độ trễ API
      print("Cập nhật trạng thái: ${isFavorite.value}");
    } catch (e) {
      print("Lỗi khi cập nhật trạng thái: $e");
    }
  }

  var playlist = <Map<String, dynamic>>[].obs;
  var currentSongIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchSongs();
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    // Lắng nghe sự thay đổi vị trí và tổng thời gian bài hát
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });
    _audioPlayer.durationStream.listen((duration) {
      this.duration.value = duration ?? Duration.zero;
    });
  }

  // Lấy danh sách bài hát từ API
  Future<void> _fetchSongs() async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        playlist.value = data.map((song) {
          return {
            'coverImageUrl': song['coverImageUrl'],
            'title': song['title'],
            'artist': song['artist'],
            'fileUrl': song['fileUrl'],
            'album': song['album'],
            'genre': song['genre'],
            'lyrics': song['lyrics'],
          };
        }).toList();

        if (playlist.isNotEmpty) {
          _updateSongInfo(0);
          await _audioPlayer.setUrl(playlist[0]['url']!);
        }
      } else {
        print('Error fetching songs: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching songs: $e");
    }
  }

  // Cập nhật thông tin
  void _updateSongInfo(int index) {
    coverImage.value = playlist[index]['coverImageUrl'] ?? ''; // Ảnh bìa
    title.value = playlist[index]['title'] ?? 'Name'; // Tiêu đề
    artist.value = playlist[index]['artist'] ?? 'Artist'; // Nghệ sĩ
    fileUrl.value = playlist[index]['fileUrl'] ?? ''; // Đường dẫn
    album.value = playlist[index]['album'] ?? ''; // Album
    genre.value = playlist[index]['genre'] ?? ''; // Thể loại
    lyrics.value = playlist[index]['lyrics'] ?? ''; // Lời bài hát
    isFavorite.value =
        playlist[index]['isFavorite'] ?? false; // Trạng thái yêu thích
  }

  // Hàm play bài hát
  Future<void> playSong(String url) async {
    if (url.isEmpty) return;

    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print("Error during playSong: $e");
    }
  }

  // Chuyển đổi play và pause
  Future<void> togglePlayPause() async {
    if (playlist.isEmpty) {
      print("Playlist is empty");
      return;
    }
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
      } else {
        if (_audioPlayer.processingState != ProcessingState.ready) {
          await _audioPlayer
              .setUrl(playlist[currentSongIndex.value]['fileUrl']!);
        }
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error during play/pause: $e");
    }
  }

  // chuyển đến bài tiếp theo
  void skipNext() async {
    if (playlist.isEmpty) {
      print("Playlist is empty");
      return;
    }

    try {
      currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['fileUrl']!);
      await _audioPlayer.play();

      // Cập nhật thông tin bài hát hiện tại
      _updateSongInfo(currentSongIndex.value);
    } catch (e) {
      print("Error during skipNext: $e");
    }
  }

  // Quay lại bài hát trước đó
  void skipPrevious() async {
    if (playlist.isEmpty) {
      print("Playlist is empty");
      return;
    }

    try {
      currentSongIndex.value =
          (currentSongIndex.value - 1 + playlist.length) % playlist.length;
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['fileUrl']!);
      await _audioPlayer.play();

      // Cập nhật thông tin bài hát hiện tại
      _updateSongInfo(currentSongIndex.value);
    } catch (e) {
      print("Error during skipPrevious: $e");
    }
  }

// Hàm tua bài hát
  void seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void onClose() {
    super.onClose();
    _audioPlayer.dispose();
  }

  // Hàm định dạng thời gian
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
