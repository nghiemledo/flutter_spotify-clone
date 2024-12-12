import 'package:client/widgets/playmusic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicController controller =
        Get.put(MusicController()); // Lấy controller đã có

    return GestureDetector(
      onTap: () {
        // Truyền thông tin bài hát vào song-detail
        Get.toNamed(
          '/song-detail',
          arguments: {
            'coverImageUrl': controller.coverImage.value,
            'title': controller.title.value,
            'artist': controller.artist.value,
            'fileUrl': controller.fileUrl.value,
            'album': controller.album.value,
            'genre': controller.genre.value,
            'lyrics': controller.lyrics.value,
            'isFavorite': controller.isFavorite.value,
          },
        );
      },
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
                              "Đang phát: ${controller.title.value}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            )),
                        Obx(() => Text(
                              controller.artist.value,
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
