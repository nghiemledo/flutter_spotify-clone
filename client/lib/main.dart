import 'package:client/screens/home/home.screen.dart';
import 'package:client/screens/library/library.sceen.dart';
import 'package:client/screens/search/search.screen.dart';
import 'package:client/widgets/navigation.widget.dart';
import 'package:client/widgets/song.widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SpotifyApp());
}

class SpotifyApp extends StatefulWidget {
  const SpotifyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpotifyCloneAppState createState() => _SpotifyCloneAppState();
}

class _SpotifyCloneAppState extends State<SpotifyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            _pages[_currentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
