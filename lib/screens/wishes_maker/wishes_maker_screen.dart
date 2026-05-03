import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/app_colors.dart';

class WishesMakerScreen extends StatefulWidget {
  const WishesMakerScreen({super.key});

  @override
  State<WishesMakerScreen> createState() => _WishesMakerScreenState();
}

class _WishesMakerScreenState extends State<WishesMakerScreen> {
  String _selectedCategory = 'Trending';

  static const _categories = [
    {'label': '🔥 Trending', 'value': 'Trending'},
    {'label': '🎂 Birthday', 'value': 'Birthday'},
    {'label': '🌙 Eid', 'value': 'Eid'},
    {'label': '🪔 Diwali', 'value': 'Diwali'},
    {'label': '❤️ Love', 'value': 'Love'},
    {'label': '💍 Shadi', 'value': 'Shadi'},
    {'label': '💪 Motivation', 'value': 'Motivation'},
  ];

  final Map<String, List<Map<String, dynamic>>> _wishes = {
    'Trending': [
      {'lang': 'EN', 'text': '"Every love story is beautiful, but ours is my favorite ❤️"', 'gradient': AppColors.gradientPink, 'likes': '89K'},
      {'lang': 'UR', 'text': '"عید مبارک! اللہ آپ کو خوش رکھے 🌙"', 'gradient': AppColors.gradientGreen, 'likes': '45K'},
      {'lang': 'HI', 'text': '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', 'gradient': AppColors.gradientOrange, 'likes': '38K'},
      {'lang': 'EN', 'text': '"Happy Birthday! Wishing you joy and laughter 🎂"', 'gradient': AppColors.gradientPurple, 'likes': '12K'},
    ],
    'Birthday': [
      {'lang': 'EN', 'text': '"Happy Birthday! May this year bring you endless joy 🎉"', 'gradient': AppColors.gradientPink, 'likes': '23K'},
      {'lang': 'HI', 'text': '"जन्मदिन मुबारक हो! 🎂"', 'gradient': AppColors.gradientOrange, 'likes': '18K'},
      {'lang': 'IT', 'text': '"Tanti auguri! Che questo anno sia pieno di felicità 🎁"', 'gradient': AppColors.gradientPurple, 'likes': '8K'},
      {'lang': 'UR', 'text': '"سالگرہ مبارک ہو! 🎂"', 'gradient': AppColors.gradientBlue, 'likes': '14K'},
    ],
    'Eid': [
      {'lang': 'UR', 'text': '"عید مبارک! اللہ آپ کو خوش رکھے 🌙✨"', 'gradient': AppColors.gradientGreen, 'likes': '45K'},
      {'lang': 'EN', 'text': '"Eid Mubarak! May Allah bless you with happiness 🌙"', 'gradient': AppColors.gradientPurple, 'likes': '32K'},
      {'lang': 'AR', 'text': '"عيد مبارك! كل عام وأنتم بخير 🌙"', 'gradient': AppColors.gradientPink, 'likes': '28K'},
    ],
    'Diwali': [
      {'lang': 'HI', 'text': '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', 'gradient': AppColors.gradientOrange, 'likes': '38K'},
      {'lang': 'EN', 'text': '"Happy Diwali! May lights guide your path 🪔"', 'gradient': AppColors.gradientPink, 'likes': '21K'},
    ],
    'Love': [
      {'lang': 'EN', 'text': '"Every love story is beautiful, but ours is my favorite ❤️"', 'gradient': AppColors.gradientPink, 'likes': '89K'},
      {'lang': 'EN', 'text': '"You are my today and all of my tomorrows 💕"', 'gradient': AppColors.gradientPurple, 'likes': '52K'},
      {'lang': 'HI', 'text': '"मेरा दिल सिर्फ तुम्हारा है ❤️"', 'gradient': AppColors.gradientOrange, 'likes': '34K'},
    ],
    'Shadi': [
      {'lang': 'HI', 'text': '"शादी मुबारक हो ✨ हमेशा खुश रहो"', 'gradient': AppColors.gradientOrange, 'likes': '16K'},
      {'lang': 'EN', 'text': '"Wishing you a lifetime of love and happiness 💍"', 'gradient': AppColors.gradientPink, 'likes': '12K'},
      {'lang': 'UR', 'text': '"شادی مبارک ہو! 💍"', 'gradient': AppColors.gradientPurple, 'likes': '9K'},
    ],
    'Motivation': [
      {'lang': 'EN', 'text': '"Don\'t wait for opportunity. Create it. 💪"', 'gradient': AppColors.gradientPurple, 'likes': '22K'},
      {'lang': 'EN', 'text': '"Dream big. Work hard. Stay focused. ✨"', 'gradient': AppColors.gradientBlue, 'likes': '18K'},
      {'lang': 'HI', 'text': '"सपने वो नहीं जो सोते हुए देखें, सपने वो हैं जो सोने न दें ✨"', 'gradient': AppColors.gradientOrange, 'likes': '15K'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final list = _wishes[_selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Wishes & Status',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: _categories.map((c) {
                  final isActive = _selectedCategory == c['value'];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = c['value']!),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.waGreenDark : AppColors.bgPage,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isActive ? AppColors.waGreenDark : AppColors.divider,
                        ),
                      ),
                      child: Text(
                        c['label']!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final wish = list[i];
                return _WishCard(
                  text: wish['text'] as String,
                  lang: wish['lang'] as String,
                  likes: wish['likes'] as String,
                  gradient: wish['gradient'] as LinearGradient,
                  onShare: () {
                    Share.share(wish['text'] as String);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _WishCard extends StatelessWidget {
  final String text;
  final String lang;
  final String likes;
  final LinearGradient gradient;
  final VoidCallback onShare;

  const _WishCard({
    required this.text,
    required this.lang,
    required this.likes,
    required this.gradient,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              lang,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    likes,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onShare,
                child: const Icon(Icons.share, color: Colors.white, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
