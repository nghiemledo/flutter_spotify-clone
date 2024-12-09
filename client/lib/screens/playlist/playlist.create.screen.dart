import 'package:flutter/material.dart';

class PlaylistCreateScreen extends StatelessWidget {
  const PlaylistCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Thêm danh sách phát"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Nhập tên danh sách phát",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),
              // Input tên danh sách phát không có border, chỉ có thanh dưới
              const TextField(
                decoration: InputDecoration(
                  hintText: "Tên danh sách phát",
                  hintStyle: TextStyle(color: Colors.grey),
                  // Chỉ hiển thị thanh gạch dưới
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              // Dòng chứa 2 nút "Hủy" và "Tạo"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Hủy
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          110, 158, 158, 158), // Màu nút Hủy
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Nút Tạo (Lưu)
                  ElevatedButton(
                    onPressed: () {
                      // Thêm logic lưu tên danh sách phát
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Màu nút Tạo
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text(
                      "Tạo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
