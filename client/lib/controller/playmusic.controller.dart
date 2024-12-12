import 'dart:async';
import 'package:client/controller/api.service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController {
  // Đối tượng AudioPlayer để phát nhạc
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ApiService _apiService = ApiService();

  // Các theo dõi trạng thái và thông tin bài hát
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var duration = Duration.zero.obs;

  // Thông tin chi tiết của bài hát
  var id = "".obs;
  var coverImage = "coverImageUrl".obs;
  var title = "title".obs;
  var artist = "artist".obs;
  var fileUrl = "fileUrl".obs;
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
    fetchAlbums();

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

  Future<void> fetchSongs() async {
    try {
      final data = await _apiService.fetchSongs();
      songs.value = List<Map<String, dynamic>>.from(data);
      playlist.value = data.map((song) => _mapSongToMap(song)).toList();

      if (playlist.isNotEmpty) {
        _updateSongInfo(0);
        await _audioPlayer.setUrl(playlist[0]['fileUrl']!);
      }
    } catch (e) {
      print('Failed to load songs: $e');
    }
  }

  Future<void> fetchAlbums() async {
    try {
      final data = await _apiService.fetchAlbums();
      playlist.value = data.map((album) => _mapAlbumToMap(album)).toList();

      if (playlist.isNotEmpty) {
        _updateSongInfo(0);
        await _audioPlayer.setUrl(playlist[0]['songs'][0]['fileUrl']);
      }
    } catch (e) {
      print('Failed to load albums: $e');
    }
  }

  Future<void> getFavoriteStatus(String songId) async {
    try {
      final data = await _apiService.getFavoriteStatus(songId);
      if (data['isFavorite'] is bool) {
        isFavorite.value = data['isFavorite'];
      } else {
        throw Exception('Invalid data type for isFavorite');
      }
    } catch (e) {
      print('Failed to load favorite status: $e');
    }
  }

  Future<void> updateFavoriteStatus(String songId) async {
    final currentStatus = isFavorite.value;
    isFavorite.value = !currentStatus;

    try {
      final updatedData =
          await _apiService.updateFavoriteStatus(songId, isFavorite.value);
      if (updatedData['isFavorite'] is bool) {
        isFavorite.value = updatedData['isFavorite'];
      }
      playlist[currentSongIndex.value]['isFavorite'] = isFavorite.value;
    } catch (e) {
      isFavorite.value = currentStatus;
      print('Failed to update favorite status: $e');
    }
  }

// Phát bài hát
  Future<void> playSong(String songId, String fileUrl) async {
    if (fileUrl.isEmpty) return;

    try {
      // Tạm dừng bài hát hiện tại nếu khác ID
      if (currentSongId.value.isNotEmpty && currentSongId.value != songId) {
        await _audioPlayer.pause();
        isPlaying.value = false;
      }

      // Cập nhật ID và URL bài hát
      currentSongId.value = songId;
      currentSongUrl.value = fileUrl;

      // Kiểm tra nếu tệp âm thanh chưa được tải, thực hiện việc tải
      if (_audioPlayer.processingState != ProcessingState.ready) {
        await _audioPlayer.setUrl(fileUrl);
      }

      // Phát bài hát mới
      await _audioPlayer.play();

      // Cập nhật trạng thái phát
      isPlaying.value = true;
    } catch (e) {
      print("Lỗi khi phát nhạc: $e");
    }
  }

// Phương thức tạm dừng nhạc
  Future<void> pauseSong() async {
    try {
      if (_audioPlayer.processingState == ProcessingState.ready) {
        await _audioPlayer.pause(); // Dừng nhạc nếu đang phát
        isPlaying.value = !isPlaying.value; // Đánh dấu là đã tạm dừng
        print('Đã tạm dừng');
      }
    } catch (e) {
      print("Lỗi khi tạm dừng nhạc: $e");
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
        // Nếu đang phát, tạm dừng
        await pauseSong();
      } else {
        // Nếu không đang phát, kiểm tra và phát bài hát
        if (_audioPlayer.processingState != ProcessingState.ready) {
          await _audioPlayer
              .setUrl(playlist[currentSongIndex.value]['fileUrl']!);
        }
        if (_audioPlayer.processingState == ProcessingState.ready) {
          await _audioPlayer.play();
        } else {
          print("Audio player chưa sẵn sàng để phát");
        }
        isPlaying.value = true; // Đánh dấu là đang phát
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

      // Kiểm tra URL bài hát tiếp theo
      String? nextSongUrl = playlist[currentSongIndex.value]['fileUrl'];
      if (nextSongUrl == null || nextSongUrl.isEmpty) {
        print("URL bài hát không hợp lệ.");
        return;
      }

      // Phát bài hát tiếp theo
      await _audioPlayer.setUrl(nextSongUrl);
      if (_audioPlayer.processingState == ProcessingState.ready) {
        await _audioPlayer.play();
      } else {
        print("Audio player chưa sẵn sàng để phát");
      }

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

      // Kiểm tra URL bài hát trước
      String? prevSongUrl = playlist[currentSongIndex.value]['fileUrl'];
      if (prevSongUrl == null || prevSongUrl.isEmpty) {
        print("URL bài hát không hợp lệ.");
        return;
      }

      // Phát bài hát trước
      await _audioPlayer.setUrl(prevSongUrl);
      if (_audioPlayer.processingState == ProcessingState.ready) {
        await _audioPlayer.play();
      } else {
        print("Audio player chưa sẵn sàng để phát");
      }

      // Cập nhật thông tin bài hát
      _updateSongInfo(currentSongIndex.value);
    } catch (e) {
      print("Lỗi khi quay lại bài trước: $e");
    }
  }

  // Cập nhật thông tin bài hát
  void _updateSongInfo(int index) {
    coverImage.value = playlist[index]['coverImageUrl'] ?? '';
    title.value = playlist[index]['title'] ?? '';
    artist.value = playlist[index]['artist'] ?? '';
    fileUrl.value = playlist[index]['fileUrl'] ?? '';
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

  Map<String, dynamic> _mapSongToMap(dynamic song) {
    return {
      'coverImageUrl': song['coverImageUrl'],
      'title': song['title'],
      'artist': song['artist'],
      'fileUrl': song['fileUrl'],
      'album': song['album'],
      'genre': song['genre'],
      'lyrics': song['lyrics'],
    };
  }

  Map<String, dynamic> _mapAlbumToMap(dynamic album) {
    return {
      'coverImageUrl': album['coverImageUrl'],
      'name': album['name'],
      'artist': album['artist'],
      'songs': album['songs'].map((song) => _mapSongToMap(song)).toList(),
    };
  }

  @override
  void onClose() {
    super.onClose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
  }
}
