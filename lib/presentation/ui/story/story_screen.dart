import 'package:flutter/material.dart';

import '../../../data/models/topic_model.dart';

class FairyTale {
  final String title;
  final String description;
  final List<Item> characters; // Các items tham gia câu chuyện

  FairyTale({
    required this.title,
    required this.description,
    required this.characters,
  });
}

const Item animalBear = Item(
  id: 'bear',
  nameEn: 'Bear',
  nameVn: 'Gấu',
  emoji: '🐻',
  color: '#C8A882',
);
const Item animalPenguin = Item(
  id: 'penguin',
  nameEn: 'Penguin',
  nameVn: 'Chim cánh cụt',
  emoji: '🐧',
  color: '#A0C8F5',
);
const Item fruitApple = Item(
  id: 'apple',
  nameEn: 'Apple',
  nameVn: 'Táo',
  emoji: '🍎',
  color: '#F5A0A0',
);
const Item fruitBanana = Item(
  id: 'banana',
  nameEn: 'Banana',
  nameVn: 'Chuối',
  emoji: '🍌',
  color: '#F5E6A0',
);
const Item objectBike = Item(
  id: 'bike',
  nameEn: 'Bike',
  nameVn: 'Xe đạp',
  emoji: '🚲',
  color: '#A0C8F5',
);
const Item objectBook = Item(
  id: 'book',
  nameEn: 'Book',
  nameVn: 'Sách',
  emoji: '📚',
  color: '#F5D4A0',
);

final List<FairyTale> demoStories = [
  FairyTale(
    title: "Bác Gấu và Phép Màu Quả Táo Đỏ",
    description:
        "Câu chuyện kể về bác Gấu tốt bụng trong rừng xanh đã chia sẻ quả táo thần kỳ cho các bạn nhỏ, dạy về lòng tham và sự chia sẻ.",
    characters: [animalBear, fruitApple],
  ),
  FairyTale(
    title: "Chú Chim Cánh Cụt Đi Xe Đạp",
    description:
        "Pip là chú chim cánh cụt vụng về nhưng mơ ước trở thành vận động viên đua xe. Chú đã nỗ lực tập luyện trên chiếc xe đạp xanh dương xinh xắn.",
    characters: [animalPenguin, objectBike, fruitBanana],
  ),
  FairyTale(
    title: "Thư Viện Bí Mật Trong Quả Chuối khổng lồ",
    description:
        "Khám phá một thế giới kỳ diệu nơi các kiến thức của nhân loại được cất giấu bên trong những trang sách nằm trong một quả chuối vàng.",
    characters: [objectBook, fruitBanana],
  ),
  FairyTale(
    title: "Cuộc Phiêu Lưu Của Quả Táo Biết Nói",
    description:
        "Một quả táo đỏ lạc khỏi giỏ hàng và bắt đầu hành trình tìm đường về nhà, trên đường đi nó gặp gỡ nhiều người bạn đồ vật thú vị.",
    characters: [fruitApple, objectBike, objectBook],
  ),
];

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng ExtendBodyToAppBar để background tràn lên cả status bar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Vương Quốc Truyện Cổ',
          style: TextStyle(
            fontFamily: 'Cosmic',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.stars_rounded, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Container(
        // Background Gradient huyền ảo
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB), // Tím đậm
              Color(0xFF2575FC), // Xanh dương
              Color(0xFFFFB74D), // Cam nhạt phía dưới
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
            itemCount: demoStories.length,
            itemBuilder: (context, index) {
              final story = demoStories[index];
              return _buildStoryCard(context, story);
            },
          ),
        ),
      ),
      // Floating button trang trí
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF4081),
        icon: const Icon(Icons.auto_stories),
        label: const Text("Khám phá thêm"),
      ),
    );
  }

  // --- Widget xây dựng từng thẻ câu chuyện ---
  Widget _buildStoryCard(BuildContext context, FairyTale story) {
    // Lấy màu chủ đạo từ nhân vật đầu tiên để phối màu cho Card
    final Color mainCharacterColor = hexToColor(story.characters.first.color);

    // Tạo màu accent đậm hơn từ màu chủ đạo
    final Color accentColor = Color.lerp(
      mainCharacterColor,
      Colors.black,
      0.4,
    )!;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9), // Trắng hơi trong suốt
        borderRadius: BorderRadius.circular(24),
        // Viền màu gradient nhẹ theo màu nhân vật
        border: Border.all(
          color: mainCharacterColor.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Trang trí góc bằng Emoji lớn mờ
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.1,
                child: Text(
                  story.characters.first.emoji,
                  style: const TextStyle(fontSize: 120),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Thời gian và List Emoji
                  Row(
                    children: story.characters.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: hexToColor(
                            item.color,
                          ).withValues(alpha: 0.3),
                          child: Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Tiêu đề truyện
                  Text(
                    story.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2C3E50),
                      fontFamily: 'Serif',
                      // Tạo cảm giác cổ điển
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Mô tả truyện
                  Text(
                    story.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Footer: Nút bấm
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainCharacterColor,
                        // Sử dụng màu của Item
                        foregroundColor: accentColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: accentColor.withValues(alpha: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Đọc Truyện Ngay",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                    ),
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
