import 'package:flutter/material.dart';

class PlaylistEditScreen extends StatelessWidget {
  const PlaylistEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Thanh tiêu đề
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.grey
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        "Chỉnh sửa PlayList",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
                const Expanded(
                    flex: 1,
                    child: Text(
                      "Lưu",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 20),
            // Ảnh PlayList
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/your_image.png'),
            ),
            const SizedBox(height: 30),
            // Nhập tên PlayList
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Nhập lại PlayList của bạn!",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 50),
            // Button mô tả
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Thêm phần mô tả",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 30),
            //View PlayList
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return _buildPlaylistItem(
                    "Lời Tạm Biệt Chưa Nói",
                    "GREY D, Orange, Kai Đinh",
                    Icons.list_outlined,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PlaylistItem
  Widget _buildPlaylistItem(String title, String author, IconData icon) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Icon(Icons.remove_circle_outline, size: 28, color: Colors.grey),
        ),
        Expanded(
          flex: 10,
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              author,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Icon(icon, size: 28, color: Colors.grey),
        ),
      ],
    );
  }
}


