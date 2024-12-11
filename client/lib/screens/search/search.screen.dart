import 'package:client/screens/search/searchresult.screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Tìm kiếm',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResultScreen()),
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Bạn muốn nghe gì?',
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                              ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Khám phá các thể loại của bạn',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "#Hip hop",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Browse All Section
            const Text(
              'Duyệt tìm tất cả',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  ),
            ),
            const SizedBox(height: 16),
            // Grid View for Categories
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2 / 1,
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              children: const [
                CategoryCard(color: Colors.blue, label: "Nhạc", imageUrl: ""),
                CategoryCard(color: Colors.red, label: "Podcast", imageUrl: ""),
                CategoryCard(color: Colors.green, label: "Tâm trạng", imageUrl: ""),
                CategoryCard(color: Colors.orange, label: "Ngủ", imageUrl: ""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget GenreCard
class GenreCard extends StatelessWidget {
  final String label;
  final Color color;
  final String imageUrl;

  const GenreCard(
      {super.key,
      required this.label,
      required this.color,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          // image: DecorationImage(
          //     image: NetworkImage(imageUrl)
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "#Hip hop",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget CategoryCard
class CategoryCard extends StatelessWidget {
  final Color color;
  final String label;
  final String imageUrl;

  const CategoryCard(
      {super.key,
      required this.color,
      required this.label,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(0.5)
                    ..translate(25.0, 10.0, 0.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
