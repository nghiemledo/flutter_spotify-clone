// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:http/http.dart' as http;

// class Api extends GetxController {
//   var playlist = <Map<String, dynamic>>[].obs;
//   var isFavorite = false.obs;
//   var isPlaying = false.obs;
//   var currentPosition = Duration.zero.obs;
//   var duration = Duration.zero.obs;
//   var currentSongIndex = 0.obs;
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void onInit() {
//     super.onInit();
//     // Tải danh sách bài hát khi controller được khởi tạo
//     fetchSongs();
//     fetchAlbums();

//     // Lắng nghe trạng thái phát nhạc
//     _audioPlayer.playerStateStream.listen((state) {
//       isPlaying.value = state.playing;
//     });

//     // Cập nhật vị trí và thời lượng bài hát
//     _audioPlayer.positionStream.listen((position) {
//       currentPosition.value = position;
//     });
//     _audioPlayer.durationStream.listen((duration) {
//       this.duration.value = duration ?? Duration.zero;
//     });
//   }

//   // Lấy danh sách bài hát từ API
//   Future<void> fetchSongs() async {
//     final url = Uri.parse(
//         'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         // Cập nhật danh sách bài hát và playlist
//         playlist.value = data.map((song) {
//           return {
//             'coverImageUrl': song['coverImageUrl'],
//             'title': song['title'],
//             'artist': song['artist'],
//             'fileUrl': song['fileUrl'],
//             'album': song['album'],
//             'genre': song['genre'],
//             'lyrics': song['lyrics'],
//             'isFavorite': song['isFavorite'] ??
//                 false, // Thêm trường isFavorite nếu không có
//           };
//         }).toList();

//         // Nếu playlist không rỗng, phát bài đầu tiên
//         if (playlist.isNotEmpty) {
//           _updateSongInfo(0);
//           await _audioPlayer.setUrl(playlist[0]['fileUrl']);
//         }
//       } else {
//         print('Lỗi tải bài hát: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Lỗi tải bài hát: $e");
//     }
//   }

//   // Cập nhật thông tin bài hát hiện tại
//   void _updateSongInfo(int index) {
//     currentSongIndex.value = index;
//     isFavorite.value = playlist[index]['isFavorite'];
//   }

//   // Kiểm tra và lấy trạng thái yêu thích của bài hát
//   Future<void> getFavoriteStatus(String songId) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId'),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Cập nhật trạng thái yêu thích
//         if (data['isFavorite'] is bool) {
//           isFavorite.value = data['isFavorite'];
//         } else {
//           throw Exception('Kiểu dữ liệu không hợp lệ cho isFavorite');
//         }
//       } else {
//         throw Exception(
//             'Không thể tải trạng thái yêu thích. Mã trạng thái: ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Lỗi',
//         'Không thể tải trạng thái yêu thích: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // Cập nhật trạng thái yêu thích của bài hát
//   Future<void> updateFavoriteStatus(String songId) async {
//     final currentStatus = isFavorite.value;
//     isFavorite.value = !currentStatus;

//     try {
//       final response = await http.put(
//         Uri.parse(
//             'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts/$songId'),
//         body: jsonEncode({'isFavorite': isFavorite.value}),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final updatedData = jsonDecode(response.body);

//         // Đồng bộ trạng thái từ phản hồi API
//         if (updatedData['isFavorite'] is bool) {
//           isFavorite.value = updatedData['isFavorite'];
//         }

//         // Tải lại danh sách bài hát sau khi cập nhật
//         playlist[currentSongIndex.value]['isFavorite'] = isFavorite.value;
//       } else {
//         // Hoàn nguyên trạng thái nếu thất bại
//         isFavorite.value = currentStatus;
//       }
//     } catch (e) {
//       // Hoàn nguyên trạng thái nếu có lỗi
//       isFavorite.value = currentStatus;
//       Get.snackbar(
//         'Lỗi',
//         'Đã xảy ra lỗi: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   // Lấy danh sách album từ API
//   Future<void> fetchAlbums() async {
//     final url = Uri.parse(
//         'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/products');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         // Cập nhật playlist từ album
//         playlist.value = data.map((album) {
//           return {
//             'coverImageUrl': album['coverImageUrl'],
//             'name': album['name'],
//             'artist': album['artist'],
//             'songs': album['songs'].map((song) {
//               return {
//                 '_id': song['_id'],
//                 'coverImageUrl': song['coverImageUrl'],
//                 'title': song['title'],
//                 'artist': song['artist'],
//                 'fileUrl': song['fileUrl'],
//                 'album': song['album'],
//                 'genre': song['genre'],
//                 'lyrics': song['lyrics'],
//               };
//             }).toList(),
//           };
//         }).toList();

//         // Nếu có ít nhất một album, chọn bài hát đầu tiên
//         if (playlist.isNotEmpty) {
//           _updateSongInfo(0); // Cập nhật thông tin bài hát đầu tiên
//           await _audioPlayer.setUrl(playlist[0]['songs'][0]['fileUrl']);
//         }
//       } else {
//         print('Lỗi tải album: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Lỗi tải album: $e");
//     }
//   }
// }
