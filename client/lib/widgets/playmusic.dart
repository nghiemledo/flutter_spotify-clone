import 'dart:convert';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var songName = "Name".obs;
  var artistName = "Artist Name".obs;
  var fileUrl = "fileUrl".obs;
  var coverImageUrl = "coverImageUrl".obs;

  var playlist = <Map<String, dynamic>>[].obs;
  var currentSongIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchSongs();

    // Lắng nghe trạng thái của trình phát
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  Future<void> _fetchSongs() async {
    final url = Uri.parse(
        'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        playlist.value = data.map((song) {
          return {
            'songName': song['title'],
            'artistName': song['artist'],
            'fileUrl': song['fileUrl'],
            'coverImageUrl': song['coverImageUrl'],
          };
        }).toList();

        // Cập nhật thông tin bài hát đầu tiên
        if (playlist.isNotEmpty) {
          currentSongIndex.value = 0;
          songName.value = playlist[0]['songName'] ?? 'Default Name';
          artistName.value = playlist[0]['artistName']!;
          coverImageUrl.value = playlist[0]['coverImageUrl']!;

          await _audioPlayer.setUrl(playlist[0]['fileUrl']!);
        }
      } else {
        print('Error fetching songs: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching songs: $e");
    }
  }

  void togglePlayPause() async {
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
      songName.value = playlist[currentSongIndex.value]['songName']!;
      artistName.value = playlist[currentSongIndex.value]['artistName']!;
      fileUrl.value = playlist[currentSongIndex.value]['fileUrl']!;
    } catch (e) {
      print("Error during skipNext: $e");
    }
  }

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
      songName.value = playlist[currentSongIndex.value]['songName']!;
      artistName.value = playlist[currentSongIndex.value]['artistName']!;
      fileUrl.value = playlist[currentSongIndex.value]['fileUrl']!;
    } catch (e) {
      print("Error during skipPrevious: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    _audioPlayer.dispose();
  }
}
