import 'package:flutter/material.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.music_note, color: Colors.white),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đang phát: Song Name",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "Artist Name",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.pause, color: Colors.white)),
                  const SizedBox(width: 18),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.skip_next, color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
