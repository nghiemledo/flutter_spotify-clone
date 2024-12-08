import 'package:flutter/material.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          Row(
            children: [
              Icon(Icons.pause, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.skip_next, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
