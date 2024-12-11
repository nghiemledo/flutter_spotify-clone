import 'package:client/screens/playlist/playlist.screen.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white24,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  _controller.clear();
                },
              ),
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return PlayListScreen(
                title: "Lời Tạm Biệt Chưa Nói",
                author: "GREY D, Orange, Kai Đinh",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFLUCy0cckz2AUEnf6hFfqK3U1vqSjMuK-Q&s",
                icon: Icons.more_vert,
              );
            },
          ),
        )
    );
  }
}
