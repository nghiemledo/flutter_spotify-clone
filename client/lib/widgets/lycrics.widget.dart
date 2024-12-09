import 'package:flutter/material.dart';

class Lyrics extends StatefulWidget {
  const Lyrics({super.key});

  @override
  State<Lyrics> createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color(0xff2e2e45),
        ),
        child: Column(
          children: [
            // Thanh tiêu đề
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff2e2e45).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Text("Chúng ta của hiện tại",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            )),
                        Text("Sơn Tùng M-TP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                  const Expanded(
                      flex: 1,
                      child: Icon(Icons.more_vert,
                          color: Colors.white, size: 30)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Lời bài hát hiển thị
            const Expanded(
              child: SingleChildScrollView(
                  child: Text("Biết em thương người ấy đã rất nhiều ",
                      style: TextStyle(color: Colors.white, fontSize: 25))),
            ),
            // Thanh công cụ và chạy nhạc
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff2e2e45).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Slider(
                      value: 71,
                      min: 0,
                      max: 283,
                      activeColor: Colors.white,
                      inactiveColor: const Color(0xFF272727),
                      onChanged: (value) {}),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("1:11",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          )),
                      Text("4:43",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ))
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 8,
                          child: Icon(Icons.play_circle,
                              color: Colors.white, size: 70)),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.share_outlined,
                              color: Colors.white, size: 30)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

