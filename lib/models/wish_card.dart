import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';

class WishCard {
  final String id;
  final String text;
  final String lang;
  final String likes;
  final LinearGradient gradient;
  final String category;

  const WishCard({
    required this.id,
    required this.text,
    required this.lang,
    required this.likes,
    required this.gradient,
    required this.category,
  });
}

const kAllWishes = <WishCard>[
  // Trending (mix)
  WishCard(id: 't1', text: '"Every love story is beautiful, but ours is my favorite ❤️"', lang: 'EN', likes: '89K', gradient: AppColors.gradientPink, category: 'Trending'),
  WishCard(id: 't2', text: '"عید مبارک! اللہ آپ کو خوش رکھے 🌙"', lang: 'UR', likes: '45K', gradient: AppColors.gradientGreen, category: 'Trending'),
  WishCard(id: 't3', text: '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', lang: 'HI', likes: '38K', gradient: AppColors.gradientOrange, category: 'Trending'),
  WishCard(id: 't4', text: '"Happy Birthday! Wishing you joy and laughter 🎂"', lang: 'EN', likes: '12K', gradient: AppColors.gradientPurple, category: 'Trending'),

  // Birthday
  WishCard(id: 'b1', text: '"Happy Birthday! May this year bring you endless joy 🎉"', lang: 'EN', likes: '23K', gradient: AppColors.gradientPink, category: 'Birthday'),
  WishCard(id: 'b2', text: '"जन्मदिन मुबारक हो! 🎂 आप हमेशा खुश रहो"', lang: 'HI', likes: '18K', gradient: AppColors.gradientOrange, category: 'Birthday'),
  WishCard(id: 'b3', text: '"Tanti auguri! Che questo anno sia pieno di felicità 🎁"', lang: 'IT', likes: '8K', gradient: AppColors.gradientPurple, category: 'Birthday'),
  WishCard(id: 'b4', text: '"سالگرہ مبارک ہو! اللہ آپ کو لمبی عمر دے 🎂"', lang: 'UR', likes: '14K', gradient: AppColors.gradientBlue, category: 'Birthday'),
  WishCard(id: 'b5', text: '"Wishing you a fantastic birthday filled with love and surprises! 🎈"', lang: 'EN', likes: '11K', gradient: AppColors.gradientGreen, category: 'Birthday'),

  // Eid
  WishCard(id: 'e1', text: '"عید مبارک! اللہ آپ کو خوش رکھے 🌙✨"', lang: 'UR', likes: '45K', gradient: AppColors.gradientGreen, category: 'Eid'),
  WishCard(id: 'e2', text: '"Eid Mubarak! May Allah bless you with happiness 🌙"', lang: 'EN', likes: '32K', gradient: AppColors.gradientPurple, category: 'Eid'),
  WishCard(id: 'e3', text: '"عيد مبارك! كل عام وأنتم بخير 🌙"', lang: 'AR', likes: '28K', gradient: AppColors.gradientPink, category: 'Eid'),
  WishCard(id: 'e4', text: '"ईद मुबारक! अल्लाह आपको खुश रखे 🌙"', lang: 'HI', likes: '21K', gradient: AppColors.gradientBlue, category: 'Eid'),

  // Diwali
  WishCard(id: 'd1', text: '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', lang: 'HI', likes: '38K', gradient: AppColors.gradientOrange, category: 'Diwali'),
  WishCard(id: 'd2', text: '"Happy Diwali! May lights guide your path to prosperity 🪔"', lang: 'EN', likes: '21K', gradient: AppColors.gradientPink, category: 'Diwali'),
  WishCard(id: 'd3', text: '"Wishing you a Diwali full of light, joy and sweetness 🪔"', lang: 'EN', likes: '15K', gradient: AppColors.gradientPurple, category: 'Diwali'),

  // Love
  WishCard(id: 'l1', text: '"Every love story is beautiful, but ours is my favorite ❤️"', lang: 'EN', likes: '89K', gradient: AppColors.gradientPink, category: 'Love'),
  WishCard(id: 'l2', text: '"You are my today and all of my tomorrows 💕"', lang: 'EN', likes: '52K', gradient: AppColors.gradientPurple, category: 'Love'),
  WishCard(id: 'l3', text: '"मेरा दिल सिर्फ तुम्हारा है ❤️"', lang: 'HI', likes: '34K', gradient: AppColors.gradientOrange, category: 'Love'),
  WishCard(id: 'l4', text: '"Sei il sole nei miei giorni grigi ☀️❤️"', lang: 'IT', likes: '12K', gradient: AppColors.gradientGreen, category: 'Love'),
  WishCard(id: 'l5', text: '"تم میری زندگی کا سب سے خوبصورت حصہ ہو ❤️"', lang: 'UR', likes: '28K', gradient: AppColors.gradientBlue, category: 'Love'),

  // Shadi (Wedding)
  WishCard(id: 's1', text: '"शादी मुबारक हो ✨ हमेशा खुश रहो"', lang: 'HI', likes: '16K', gradient: AppColors.gradientOrange, category: 'Shadi'),
  WishCard(id: 's2', text: '"Wishing you a lifetime of love and happiness 💍"', lang: 'EN', likes: '12K', gradient: AppColors.gradientPink, category: 'Shadi'),
  WishCard(id: 's3', text: '"شادی مبارک ہو! اللہ آپ کے رشتے کو ہمیشہ سلامت رکھے 💍"', lang: 'UR', likes: '9K', gradient: AppColors.gradientPurple, category: 'Shadi'),

  // Motivation
  WishCard(id: 'm1', text: '"Don\'t wait for opportunity. Create it. 💪"', lang: 'EN', likes: '22K', gradient: AppColors.gradientPurple, category: 'Motivation'),
  WishCard(id: 'm2', text: '"Dream big. Work hard. Stay focused. ✨"', lang: 'EN', likes: '18K', gradient: AppColors.gradientBlue, category: 'Motivation'),
  WishCard(id: 'm3', text: '"सपने वो नहीं जो सोते हुए देखें, सपने वो हैं जो सोने न दें ✨"', lang: 'HI', likes: '15K', gradient: AppColors.gradientOrange, category: 'Motivation'),
  WishCard(id: 'm4', text: '"Every morning is a chance to start fresh 🌅"', lang: 'EN', likes: '11K', gradient: AppColors.gradientGreen, category: 'Motivation'),
];

List<Map<String, String>> getCategories(AppLocalizations s) => [
      {'label': s.wishCatTrending, 'value': 'Trending'},
      {'label': s.wishCatBirthday, 'value': 'Birthday'},
      {'label': s.wishCatEid, 'value': 'Eid'},
      {'label': s.wishCatDiwali, 'value': 'Diwali'},
      {'label': s.wishCatLove, 'value': 'Love'},
      {'label': s.wishCatShadi, 'value': 'Shadi'},
      {'label': s.wishCatMotivation, 'value': 'Motivation'},
    ];
