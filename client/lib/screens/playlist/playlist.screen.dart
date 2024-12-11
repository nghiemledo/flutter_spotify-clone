import 'package:client/screens/song/songdetail.screen.dart';
import 'package:flutter/material.dart';

class PlayListScreen extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final IconData icon;

  const PlayListScreen({super.key, 
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SongDetailScreen()),
          );
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  author,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(height: 10),
          ],
        ));
  }
}
