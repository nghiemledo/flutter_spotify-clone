import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class AlbumController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var album = {}.obs;
  var songs = <Map<String, dynamic>>[].obs;
  var playlist = <Map<String, dynamic>>[].obs;
  var currentSongIndex = 0.obs;
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs; // Thời gian hiện tại của bài hát
  var duration = Duration.zero.obs; // Tổng thời gian của bài hát
  var coverImage = "coverImageUrl".obs;
  var title = "title".obs;
  var artist = "artist".obs;
  var url = "url".obs;
  var id = "".obs;
  // var album = "album".obs;
  var genre = "genre".obs;
  var lyrics = "lyrics".obs;
  var isFavorite = false.obs;
  // Phương thức để cập nhật dữ liệu album
  void setAlbum(Map<String, dynamic> newAlbum) {
    album.value = newAlbum;
  }

  @override
  void onInit() {
    super.onInit();
    // Tải danh sách bài hát khi controller được khởi tạo
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/products'); // Replace with your actual API URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Assuming each album has a list of songs, you can modify it like below
        playlist.value = data.map((album) {
          return {
            'coverImageUrl': album['coverImageUrl'], // Album cover image
            'name': album['name'], // Album name
            'artist': album['artist'], // Artist name
            'songs': album['songs'].map((song) {
              return {
                'coverImageUrl': song['coverImageUrl'],
                'title': song['title'],
                'artist': song['artist'],
                'fileUrl': song['fileUrl'],
                'album': song['album'],
                'genre': song['genre'],
                'lyrics': song['lyrics'],
              };
            }).toList(),
          };
        }).toList();
        // You can choose to load the first song of the first album
        if (playlist.isNotEmpty) {
          _updateSongInfo(0); // Updates the first song's details
          await _audioPlayer.setUrl(playlist[0]['songs'][0]['fileUrl']);
        }
      } else {
        print('Error fetching albums: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching albums: $e");
    }
  }

  void _updateSongInfo(int index) {
    coverImage.value = playlist[index]['coverImageUrl'] ?? ''; // Ảnh bìa
    title.value = playlist[index]['title'] ?? 'Name'; // Tiêu đề
    artist.value = playlist[index]['artist'] ?? 'Artist'; // Nghệ sĩ
    url.value = playlist[index]['fileUrl'] ?? ''; // Đường dẫn
    album.value = playlist[index]['album'] ?? ''; // Album
    genre.value = playlist[index]['genre'] ?? ''; // Thể loại
    lyrics.value = playlist[index]['lyrics'] ?? ''; // Lời bài hát
    isFavorite.value =
        playlist[index]['isFavorite'] ?? false; // Trạng thái yêu thích
  }
}
