import 'package:flutter/material.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildStatsRow(),
            _buildTabBar(),
            const SizedBox(height: 20),
            _buildSectionTitle('Phổ Biến'),
            _buildSongList(),
            const SizedBox(height: 20),
            _buildSectionTitle('Bản phát hành mới phổ biến'),
            _buildReleaseSection(),
            const SizedBox(height: 30),
            _buildSectionTitle(''),
            _buildSeeMusicListButton(),
            const SizedBox(height: 30),
            _buildSectionTitle('có sự tham gia của Sơn Tùng M-TP'),
            _buildIntroCards(),
            const SizedBox(height: 20),
            _buildSectionTitle('Các đoạn video của Sơn Tùng'),
            const SizedBox(height: 30),
            _buildVideosSection(),
            const SizedBox(height: 30),
            _buildSectionIntroduce('Giới thiệu'),
            const SizedBox(height: 20),
            _buildIntroduceSection(),
            const SizedBox(height: 30),
            _buildSectionListTitle('Playlist dựa trên nghệ sĩ'),
            _buildListCard(),
            const SizedBox(height: 20),
            _buildSectionTitle('Các avatar FAN thích'),
            const SizedBox(height: 30),
            _buildIntroAvatarCards(context, screenWidth / 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      color: Colors.orangeAccent,
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: const Row(
        children: [
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Sơn Tùng M-TP',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      color: Colors.grey[850],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1 triệu người nghe mỗi tháng',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Theo dõi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
            onPressed: () {},
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: Colors.green,
            ),
            onPressed: () {},
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('Âm nhạc', style: TextStyle(color: Colors.white, fontSize: 15)),
          SizedBox(width: 20),
          Text('Đoạn video', style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSongList() {
    return Column(
      children: [
        _buildSongTile('Đừng Làm Trái Tim Anh Đau', '100000000 lượt nghe'),
        const SizedBox(height: 16),
        _buildSongTile('Chúng Ta Của Tương Lai', '100000000 lượt nghe'),
      ],
    );
  }

  Widget _buildSongTile(String title, String subtitle) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.more_vert, color: Colors.white),
      onTap: () {},
    );
  }

  Widget _buildReleaseSection() {
    return Column(
      children: [
        _buildSongTile('M-TP Album', '2017-album'),
        const SizedBox(height: 16),
        _buildSongTile('Đừng làm trái tim anh đau', '2024 đĩa đơn'),
      ],
    );
  }

  Widget _buildSeeMusicListButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: const Text(
              'Xem danh sách đĩa nhạc',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
            (index) => Flexible(
          flex: 1,
          child: _buildIntroCard(),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=60&lazy=load',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sơn Tùng M-TP Radio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideosSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.network(
        'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
  Widget _buildSectionIntroduce(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIntroduceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.network(
        'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
  Widget _buildIntroAvatarCards(BuildContext context, double avatarRadius) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
              (index) => Flexible(
            flex: 1,
            child: _buildAvatarCard(
              'Sơn Tùng ${index + 1}',
              'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=60&lazy=load',
              avatarRadius: avatarRadius,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarCard(String name, String imageUrl, {double avatarRadius = 30}) {
    return Column(
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSectionListTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
            (index) => Flexible(
          flex: 1,
          child: _buildListCardItem(index),
        ),
      ),
    );
  }

  Widget _buildListCardItem(int index) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.pexels.com/photos/29609563/pexels-photo-29609563.jpeg?auto=compress&cs=tinysrgb&w=60&lazy=load',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Danh sách phát ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
