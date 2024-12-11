import 'package:client/screens/album/album.screen.dart';
import 'package:client/screens/authentication/authentication.screen.dart';
import 'package:client/screens/authentication/login.screen.dart';
import 'package:client/screens/authentication/register.screen.dart';
import 'package:client/screens/home/home.screen.dart';
import 'package:client/screens/library/library.sceen.dart';
import 'package:client/screens/search/search.screen.dart';
import 'package:client/screens/song/songdetail.screen.dart';
import 'package:client/screens/user/favoritelist.screen.dart';
import 'package:client/screens/user/profile.screen.dart';
import 'package:client/widgets/lycrics.widget.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/playmusic.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(MusicController());
  runApp(const SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/library', page: () => const LibraryScreen()),
        GetPage(name: '/song-detail', page: () => SongDetailScreen()),
        GetPage(name: '/user-profile', page: () => const ProfileScreen()),
        GetPage(name: '/favorite-list', page: () => const FavoriteListScreen()),
        GetPage(name: '/lyrics', page: () => const Lyrics()),
        GetPage(name: '/song-detail', page: () => SongDetailScreen()),
        GetPage(name: '/album', page: () => const AlbumScreen()),
        GetPage(name: '/sign-up', page: () => const SignUpScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
      ],
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialPage;

  const MainScreen({super.key, this.initialPage = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SongWidget(),
          NavigationWidget(
            currentIndex: _currentIndex,
            onTabSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
