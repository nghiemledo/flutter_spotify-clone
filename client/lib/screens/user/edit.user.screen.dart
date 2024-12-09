import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // Hàm xử lý lưu thông tin
  void _saveUserInfo() {
    if (_formKey.currentState?.validate() ?? false) {
      // Xử lý lưu thông tin người dùng
      String name = _nameController.text;

      // Hiển thị thông tin đã lưu (hoặc có thể gửi lên server)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Thông tin người dùng đã được lưu!\nTên: $name'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Text(
              "Lưu",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            onPressed: _saveUserInfo,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ảnh người dùng (hình tròn)
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  "https://example.com/user_image.jpg"), // Đặt URL hình ảnh người dùng
            ),
            const SizedBox(height: 20),

            // Form chỉnh sửa tên người dùng
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Trường nhập tên người dùng
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 21),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Nhập tên của bạn',
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
