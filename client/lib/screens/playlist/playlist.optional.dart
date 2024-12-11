import 'package:client/screens/song/songdetail.screen.dart';
import 'package:flutter/material.dart';

class PlayListItemSearch extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  PlayListItemSearch({
    required this.title,
    required this.author,
    required this.imageUrl,
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
            IconButton(
              icon: const Icon(Icons.more_vert,size: 28, color: Colors.white),
              onPressed: () {
                _showMoreOptionsSeach(context);
              },
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}

class PlayListItem extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  PlayListItem({
    required this.title,
    required this.author,
    required this.imageUrl,
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
            const Icon(Icons.add_circle_outline,size: 28, color: Colors.white),
            
            const SizedBox(height: 10),
          ],
        ));
  }
}


void _showMoreOptionsSeach(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Thêm vào Bài hát đã thích'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Thêm vào danh sách phát'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Chia sẻ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_check_circle_outlined),
              title: const Text('Chuyển đến album'),
              onTap: () {},
            ),
          ],
        ),
      );
    },
  );
}
