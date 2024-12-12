import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String songsApiUrl =
      'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/contacts';
  static const String albumsApiUrl =
      'https://66e2f263494df9a478e3be18.mockapi.io/api/v1/products';

  Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse(songsApiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load songs: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http.get(Uri.parse(albumsApiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getFavoriteStatus(String songId) async {
    final response = await http.get(Uri.parse('$songsApiUrl/$songId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load favorite status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateFavoriteStatus(
      String songId, bool isFavorite) async {
    final response = await http.put(
      Uri.parse('$songsApiUrl/$songId'),
      body: jsonEncode({'isFavorite': isFavorite}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to update favorite status: ${response.statusCode}');
    }
  }
}
