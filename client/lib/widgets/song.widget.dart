import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class SongWidget extends StatelessWidget {
  const SongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicController controller = Get.put(MusicController());

    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, '/song-detail')},
      child: Container(
        color: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[900],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              "Đang phát: ${controller.songName.value}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            )),
                        Obx(() => Text(
                              controller.artistName.value,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Obx(() => IconButton(
                        onPressed: controller.togglePlayPause,
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(width: 18),
                  IconButton(
                    onPressed: controller.skipNext,
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var isPaused = false.obs;
  var songName = "Song Name".obs;
  var artistName = "Artist Name".obs;

  // Danh sách bài hát trong playlist
  // var playlist = <Map<String, dynamic>>[].obs;
  final List<Map<String, String>> playlist = [
    {
      'songName': 'SoundHelix Song 1',
      'artistName': 'Artist 1',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
    },
    {
      'songName': 'SoundHelix Song 2',
      'artistName': 'Artist 2',
      'url':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg'
    },
    {
      'songName': 'SoundHelix Song 3',
      'artistName': 'Artist 3',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'
    }
  ];

  var currentSongIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // _fetchSong();
    _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);

    // Lắng nghe sự kiện
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  // Future<void> _fetchSong() async {
  //   final url = Uri.parse('');
  //   try {
  //     final res = await http.get(url);
  //     if (res.statusCode == 200) {
  //       final List<dynamic> data = json.decode(res.body);
  //       playlist.value = data.map((song) {
  //         return {
  //           'songName': song['name'],
  //           'artistName': song['artist'],
  //           'url': song['url'],
  //         };
  //       }).toList();
  //     } else {
  //       print('error');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //Phát và tạm dừng
  void togglePlayPause() async {
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error during play/pause: $e");
    }
  }

  void skipNext() async {
    try {
      currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);
      await _audioPlayer.play();
      songName.value = playlist[currentSongIndex.value]['songName']!;
      artistName.value = playlist[currentSongIndex.value]['artistName']!;
    } catch (e) {
      print("Error during skipNext: $e");
    }
  }

// Quay lại bài hát trước
  void skipPrevious() async {
    try {
      currentSongIndex.value =
          (currentSongIndex.value - 1 + playlist.length) % playlist.length;
      await _audioPlayer.setUrl(playlist[currentSongIndex.value]['url']!);
      await _audioPlayer.play(); // Phát bài trước
      songName.value = playlist[currentSongIndex.value]['songName']!;
      artistName.value = playlist[currentSongIndex.value]['artistName']!;
    } catch (e) {
      print("Error during skipPrevious: $e");
    }
  }

// Giải phóng tài nguyên
  @override
  void onClose() {
    super.onClose();
    _audioPlayer.dispose();
  }
}
