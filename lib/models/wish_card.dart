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

const _gPink = AppColors.gradientPink;
const _gGreen = AppColors.gradientGreen;
const _gPurple = AppColors.gradientPurple;
const _gOrange = AppColors.gradientOrange;
const _gBlue = AppColors.gradientBlue;

const kAllWishes = <WishCard>[
  // ===== TRENDING (mix of best from each category) =====
  WishCard(id: 't1', text: '"Every love story is beautiful, but ours is my favorite ❤️"', lang: 'EN', likes: '89K', gradient: _gPink, category: 'Trending'),
  WishCard(id: 't2', text: '"عید مبارک! اللہ آپ کو خوش رکھے 🌙"', lang: 'UR', likes: '45K', gradient: _gGreen, category: 'Trending'),
  WishCard(id: 't3', text: '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', lang: 'HI', likes: '38K', gradient: _gOrange, category: 'Trending'),
  WishCard(id: 't4', text: '"Happy Birthday! Wishing you joy and laughter 🎂"', lang: 'EN', likes: '12K', gradient: _gPurple, category: 'Trending'),
  WishCard(id: 't5', text: '"Don\'t wait for opportunity. Create it. 💪"', lang: 'EN', likes: '67K', gradient: _gBlue, category: 'Trending'),
  WishCard(id: 't6', text: '"Sei la persona più bella della mia vita ❤️"', lang: 'IT', likes: '24K', gradient: _gPink, category: 'Trending'),
  WishCard(id: 't7', text: '"You only live once, but if you do it right, once is enough ✨"', lang: 'EN', likes: '52K', gradient: _gPurple, category: 'Trending'),
  WishCard(id: 't8', text: '"शुभ प्रभात! आज का दिन खूबसूरत हो ☀️"', lang: 'HI', likes: '31K', gradient: _gOrange, category: 'Trending'),

  // ===== BIRTHDAY =====
  WishCard(id: 'b1', text: '"Happy Birthday! May this year bring you endless joy 🎉"', lang: 'EN', likes: '23K', gradient: _gPink, category: 'Birthday'),
  WishCard(id: 'b2', text: '"जन्मदिन मुबारक हो! 🎂 आप हमेशा खुश रहो"', lang: 'HI', likes: '18K', gradient: _gOrange, category: 'Birthday'),
  WishCard(id: 'b3', text: '"Tanti auguri! Che questo anno sia pieno di felicità 🎁"', lang: 'IT', likes: '8K', gradient: _gPurple, category: 'Birthday'),
  WishCard(id: 'b4', text: '"سالگرہ مبارک ہو! اللہ آپ کو لمبی عمر دے 🎂"', lang: 'UR', likes: '14K', gradient: _gBlue, category: 'Birthday'),
  WishCard(id: 'b5', text: '"Wishing you a fantastic birthday filled with love and surprises! 🎈"', lang: 'EN', likes: '11K', gradient: _gGreen, category: 'Birthday'),
  WishCard(id: 'b6', text: '"عید میلاد مبارک! 🎂 ہر سال اس سے بھی بہتر ہو"', lang: 'UR', likes: '9K', gradient: _gPink, category: 'Birthday'),
  WishCard(id: 'b7', text: '"Buon compleanno amore mio! Sei tutto per me ❤️🎂"', lang: 'IT', likes: '15K', gradient: _gPink, category: 'Birthday'),
  WishCard(id: 'b8', text: '"Another year older, another year wiser, another year more amazing 🌟"', lang: 'EN', likes: '17K', gradient: _gBlue, category: 'Birthday'),
  WishCard(id: 'b9', text: '"आज का दिन आपके लिए खास हो! जन्मदिन की शुभकामनाएं 🎉"', lang: 'HI', likes: '21K', gradient: _gOrange, category: 'Birthday'),
  WishCard(id: 'b10', text: '"Cheers to you on your special day! Make every moment count 🥳"', lang: 'EN', likes: '13K', gradient: _gPurple, category: 'Birthday'),
  WishCard(id: 'b11', text: '"عيد ميلاد سعيد! كل عام وأنت بخير 🎂"', lang: 'AR', likes: '19K', gradient: _gGreen, category: 'Birthday'),
  WishCard(id: 'b12', text: '"100 di questi giorni! Auguri di cuore 🎉"', lang: 'IT', likes: '10K', gradient: _gOrange, category: 'Birthday'),
  WishCard(id: 'b13', text: '"May your birthday be the start of a year filled with good luck 🍀"', lang: 'EN', likes: '14K', gradient: _gGreen, category: 'Birthday'),
  WishCard(id: 'b14', text: '"دل سے دعا ہے کہ آپ کی زندگی خوشیوں سے بھر جائے 🎂"', lang: 'UR', likes: '11K', gradient: _gPurple, category: 'Birthday'),
  WishCard(id: 'b15', text: '"भगवान आपको लंबी और खुशहाल जिंदगी दे! 🎂🙏"', lang: 'HI', likes: '16K', gradient: _gPink, category: 'Birthday'),
  WishCard(id: 'b16', text: '"Auguri di buon compleanno! Che i tuoi sogni si avverino 🌟"', lang: 'IT', likes: '7K', gradient: _gBlue, category: 'Birthday'),

  // ===== EID =====
  WishCard(id: 'e1', text: '"عید مبارک! اللہ آپ کو خوش رکھے 🌙✨"', lang: 'UR', likes: '45K', gradient: _gGreen, category: 'Eid'),
  WishCard(id: 'e2', text: '"Eid Mubarak! May Allah bless you with happiness 🌙"', lang: 'EN', likes: '32K', gradient: _gPurple, category: 'Eid'),
  WishCard(id: 'e3', text: '"عيد مبارك! كل عام وأنتم بخير 🌙"', lang: 'AR', likes: '28K', gradient: _gPink, category: 'Eid'),
  WishCard(id: 'e4', text: '"ईद मुबारक! अल्लाह आपको खुश रखे 🌙"', lang: 'HI', likes: '21K', gradient: _gBlue, category: 'Eid'),
  WishCard(id: 'e5', text: '"Wishing you and your family a blessed Eid 🌙✨"', lang: 'EN', likes: '24K', gradient: _gGreen, category: 'Eid'),
  WishCard(id: 'e6', text: '"اس عید پر آپ کو ہر خوشی نصیب ہو 🌙"', lang: 'UR', likes: '18K', gradient: _gOrange, category: 'Eid'),
  WishCard(id: 'e7', text: '"May Allah accept your prayers and grant you peace 🤲"', lang: 'EN', likes: '15K', gradient: _gPurple, category: 'Eid'),
  WishCard(id: 'e8', text: '"تقبل الله منا ومنكم صالح الأعمال 🌙"', lang: 'AR', likes: '22K', gradient: _gGreen, category: 'Eid'),
  WishCard(id: 'e9', text: '"Eid Mubarak from my family to yours! 🌙💚"', lang: 'EN', likes: '14K', gradient: _gPink, category: 'Eid'),
  WishCard(id: 'e10', text: '"عید کی خوشیاں آپ کے ساتھ ہوں! 🌙"', lang: 'UR', likes: '20K', gradient: _gBlue, category: 'Eid'),
  WishCard(id: 'e11', text: '"May this Eid bring peace, prosperity and happiness to your home 🏡✨"', lang: 'EN', likes: '12K', gradient: _gOrange, category: 'Eid'),
  WishCard(id: 'e12', text: '"عيد سعيد، أعاده الله علينا وعليكم 🌙"', lang: 'AR', likes: '16K', gradient: _gPurple, category: 'Eid'),

  // ===== DIWALI =====
  WishCard(id: 'd1', text: '"दीपावली की हार्दिक शुभकामनाएं 🪔✨"', lang: 'HI', likes: '38K', gradient: _gOrange, category: 'Diwali'),
  WishCard(id: 'd2', text: '"Happy Diwali! May lights guide your path to prosperity 🪔"', lang: 'EN', likes: '21K', gradient: _gPink, category: 'Diwali'),
  WishCard(id: 'd3', text: '"Wishing you a Diwali full of light, joy and sweetness 🪔"', lang: 'EN', likes: '15K', gradient: _gPurple, category: 'Diwali'),
  WishCard(id: 'd4', text: '"शुभ दीपावली! आपका जीवन खुशियों से भर जाए 🪔🌟"', lang: 'HI', likes: '28K', gradient: _gOrange, category: 'Diwali'),
  WishCard(id: 'd5', text: '"May this Diwali light up your life with happiness and success ✨"', lang: 'EN', likes: '19K', gradient: _gBlue, category: 'Diwali'),
  WishCard(id: 'd6', text: '"रोशनी का त्योहार आपके लिए खुशियाँ लाए 🪔"', lang: 'HI', likes: '22K', gradient: _gPink, category: 'Diwali'),
  WishCard(id: 'd7', text: '"Wishing you wealth, health and happiness this Diwali 💰🪔"', lang: 'EN', likes: '14K', gradient: _gGreen, category: 'Diwali'),
  WishCard(id: 'd8', text: '"माँ लक्ष्मी की कृपा आप पर बनी रहे 🙏🪔"', lang: 'HI', likes: '25K', gradient: _gOrange, category: 'Diwali'),
  WishCard(id: 'd9', text: '"Sparkle bright like Diwali lights! 🪔✨"', lang: 'EN', likes: '13K', gradient: _gPurple, category: 'Diwali'),

  // ===== LOVE =====
  WishCard(id: 'l1', text: '"Every love story is beautiful, but ours is my favorite ❤️"', lang: 'EN', likes: '89K', gradient: _gPink, category: 'Love'),
  WishCard(id: 'l2', text: '"You are my today and all of my tomorrows 💕"', lang: 'EN', likes: '52K', gradient: _gPurple, category: 'Love'),
  WishCard(id: 'l3', text: '"मेरा दिल सिर्फ तुम्हारा है ❤️"', lang: 'HI', likes: '34K', gradient: _gOrange, category: 'Love'),
  WishCard(id: 'l4', text: '"Sei il sole nei miei giorni grigi ☀️❤️"', lang: 'IT', likes: '12K', gradient: _gGreen, category: 'Love'),
  WishCard(id: 'l5', text: '"تم میری زندگی کا سب سے خوبصورت حصہ ہو ❤️"', lang: 'UR', likes: '28K', gradient: _gBlue, category: 'Love'),
  WishCard(id: 'l6', text: '"I fell in love with you because you loved me when I couldn\'t love myself 💖"', lang: 'EN', likes: '41K', gradient: _gPink, category: 'Love'),
  WishCard(id: 'l7', text: '"Quando sono con te, il mondo è perfetto 💑"', lang: 'IT', likes: '9K', gradient: _gPurple, category: 'Love'),
  WishCard(id: 'l8', text: '"तुमसे मिलकर मेरी जिंदगी हसीन हो गई 💕"', lang: 'HI', likes: '22K', gradient: _gPink, category: 'Love'),
  WishCard(id: 'l9', text: '"You\'re my favorite hello and my hardest goodbye 🥺❤️"', lang: 'EN', likes: '35K', gradient: _gBlue, category: 'Love'),
  WishCard(id: 'l10', text: '"محبت تمہاری زندگی کی سب سے بڑی دولت ہے ❤️"', lang: 'UR', likes: '17K', gradient: _gOrange, category: 'Love'),
  WishCard(id: 'l11', text: '"Distance means nothing when someone means everything 💕"', lang: 'EN', likes: '29K', gradient: _gGreen, category: 'Love'),
  WishCard(id: 'l12', text: '"تم میری دنیا، تم میری زندگی ❤️"', lang: 'UR', likes: '14K', gradient: _gPurple, category: 'Love'),
  WishCard(id: 'l13', text: '"You make me smile for absolutely no reason 😊❤️"', lang: 'EN', likes: '27K', gradient: _gPink, category: 'Love'),
  WishCard(id: 'l14', text: '"Il mio cuore batte solo per te 💗"', lang: 'IT', likes: '8K', gradient: _gBlue, category: 'Love'),
  WishCard(id: 'l15', text: '"प्यार में दूरी नहीं, बस अहसास होते हैं ❤️"', lang: 'HI', likes: '19K', gradient: _gOrange, category: 'Love'),
  WishCard(id: 'l16', text: '"In a world full of people, my eyes search for you 👀💕"', lang: 'EN', likes: '23K', gradient: _gPink, category: 'Love'),
  WishCard(id: 'l17', text: '"أنت قلبي ونبضه يا حبيبي ❤️"', lang: 'AR', likes: '13K', gradient: _gPurple, category: 'Love'),

  // ===== SHADI / WEDDING =====
  WishCard(id: 's1', text: '"शादी मुबारक हो ✨ हमेशा खुश रहो"', lang: 'HI', likes: '16K', gradient: _gOrange, category: 'Shadi'),
  WishCard(id: 's2', text: '"Wishing you a lifetime of love and happiness 💍"', lang: 'EN', likes: '12K', gradient: _gPink, category: 'Shadi'),
  WishCard(id: 's3', text: '"شادی مبارک ہو! اللہ آپ کے رشتے کو ہمیشہ سلامت رکھے 💍"', lang: 'UR', likes: '9K', gradient: _gPurple, category: 'Shadi'),
  WishCard(id: 's4', text: '"Auguri agli sposi! Che il vostro amore duri per sempre 💑"', lang: 'IT', likes: '6K', gradient: _gPink, category: 'Shadi'),
  WishCard(id: 's5', text: '"May your marriage be filled with love, laughter and happily ever after 💕"', lang: 'EN', likes: '15K', gradient: _gBlue, category: 'Shadi'),
  WishCard(id: 's6', text: '"आप दोनों की जोड़ी सलामत रहे! 💑"', lang: 'HI', likes: '13K', gradient: _gOrange, category: 'Shadi'),
  WishCard(id: 's7', text: '"مبارک ہو! نئی زندگی کی ابتدا 💍"', lang: 'UR', likes: '11K', gradient: _gGreen, category: 'Shadi'),
  WishCard(id: 's8', text: '"Two souls, one heart. Congratulations on your wedding! 👰🤵"', lang: 'EN', likes: '10K', gradient: _gPurple, category: 'Shadi'),
  WishCard(id: 's9', text: '"बधाई हो! आपके नए सफर की शुरुआत 💑✨"', lang: 'HI', likes: '14K', gradient: _gPink, category: 'Shadi'),
  WishCard(id: 's10', text: '"Felicità infinita per la vostra nuova vita insieme 💍"', lang: 'IT', likes: '5K', gradient: _gOrange, category: 'Shadi'),

  // ===== MOTIVATION =====
  WishCard(id: 'm1', text: '"Don\'t wait for opportunity. Create it. 💪"', lang: 'EN', likes: '67K', gradient: _gPurple, category: 'Motivation'),
  WishCard(id: 'm2', text: '"Dream big. Work hard. Stay focused. ✨"', lang: 'EN', likes: '45K', gradient: _gBlue, category: 'Motivation'),
  WishCard(id: 'm3', text: '"सपने वो नहीं जो सोते हुए देखें, सपने वो हैं जो सोने न दें ✨"', lang: 'HI', likes: '38K', gradient: _gOrange, category: 'Motivation'),
  WishCard(id: 'm4', text: '"Every morning is a chance to start fresh 🌅"', lang: 'EN', likes: '29K', gradient: _gGreen, category: 'Motivation'),
  WishCard(id: 'm5', text: '"Success is not final, failure is not fatal. Keep going. 🚀"', lang: 'EN', likes: '52K', gradient: _gPurple, category: 'Motivation'),
  WishCard(id: 'm6', text: '"کوشش کرنے والوں کی کبھی ہار نہیں ہوتی 💪"', lang: 'UR', likes: '21K', gradient: _gPink, category: 'Motivation'),
  WishCard(id: 'm7', text: '"Be the change you wish to see in the world 🌍"', lang: 'EN', likes: '34K', gradient: _gBlue, category: 'Motivation'),
  WishCard(id: 'm8', text: '"Chi non rischia, non vince 💯"', lang: 'IT', likes: '12K', gradient: _gOrange, category: 'Motivation'),
  WishCard(id: 'm9', text: '"मेहनत इतनी खामोशी से करो कि सफलता शोर मचा दे 🔥"', lang: 'HI', likes: '41K', gradient: _gPurple, category: 'Motivation'),
  WishCard(id: 'm10', text: '"Your only limit is your mind 🧠✨"', lang: 'EN', likes: '36K', gradient: _gGreen, category: 'Motivation'),
  WishCard(id: 'm11', text: '"Hustle in silence and let your success make the noise 💼"', lang: 'EN', likes: '48K', gradient: _gPink, category: 'Motivation'),
  WishCard(id: 'm12', text: '"خواب وہی دیکھو جو نیند سے جگا دے 🌟"', lang: 'UR', likes: '17K', gradient: _gBlue, category: 'Motivation'),
  WishCard(id: 'm13', text: '"You are stronger than you think. Keep going. 💪"', lang: 'EN', likes: '31K', gradient: _gOrange, category: 'Motivation'),
  WishCard(id: 'm14', text: '"Le grandi cose richiedono tempo. Continua. 🌱"', lang: 'IT', likes: '9K', gradient: _gGreen, category: 'Motivation'),
  WishCard(id: 'm15', text: '"खुद पर भरोसा रखो, मंज़िल खुद-ब-खुद मिलेगी 🎯"', lang: 'HI', likes: '26K', gradient: _gPink, category: 'Motivation'),

  // ===== GOOD MORNING =====
  WishCard(id: 'gm1', text: '"Good morning! Wishing you a beautiful day ahead ☀️"', lang: 'EN', likes: '34K', gradient: _gOrange, category: 'GoodMorning'),
  WishCard(id: 'gm2', text: '"शुभ प्रभात! आज का दिन खूबसूरत हो ☀️🌹"', lang: 'HI', likes: '42K', gradient: _gPink, category: 'GoodMorning'),
  WishCard(id: 'gm3', text: '"صبح بخیر! آپ کا دن خوشیوں سے بھرا ہو ☀️"', lang: 'UR', likes: '28K', gradient: _gPurple, category: 'GoodMorning'),
  WishCard(id: 'gm4', text: '"Buongiorno! Che oggi sia un giorno meraviglioso ☀️"', lang: 'IT', likes: '11K', gradient: _gBlue, category: 'GoodMorning'),
  WishCard(id: 'gm5', text: '"Rise and shine, beautiful soul ✨🌅"', lang: 'EN', likes: '22K', gradient: _gOrange, category: 'GoodMorning'),
  WishCard(id: 'gm6', text: '"सुप्रभात! भगवान आपका दिन शुभ करे 🙏☀️"', lang: 'HI', likes: '36K', gradient: _gGreen, category: 'GoodMorning'),
  WishCard(id: 'gm7', text: '"صبح کے ساتھ نئی امیدیں، نئی خوشیاں 🌅"', lang: 'UR', likes: '19K', gradient: _gPink, category: 'GoodMorning'),
  WishCard(id: 'gm8', text: '"Today is a fresh start. Make it amazing! 🌟"', lang: 'EN', likes: '27K', gradient: _gPurple, category: 'GoodMorning'),
  WishCard(id: 'gm9', text: '"Buongiorno mio amore! Inizia bene la tua giornata ❤️"', lang: 'IT', likes: '8K', gradient: _gPink, category: 'GoodMorning'),
  WishCard(id: 'gm10', text: '"उठो, मुस्कुराओ, और दिन को खूबसूरत बनाओ 😊"', lang: 'HI', likes: '24K', gradient: _gOrange, category: 'GoodMorning'),
  WishCard(id: 'gm11', text: '"صباح الخير! يوم سعيد لك ☀️"', lang: 'AR', likes: '16K', gradient: _gGreen, category: 'GoodMorning'),
  WishCard(id: 'gm12', text: '"Sending you positive vibes for the day ahead 🌈"', lang: 'EN', likes: '20K', gradient: _gBlue, category: 'GoodMorning'),

  // ===== FRIENDS =====
  WishCard(id: 'f1', text: '"Best friends are the family we choose 💛"', lang: 'EN', likes: '38K', gradient: _gOrange, category: 'Friends'),
  WishCard(id: 'f2', text: '"दोस्ती में सब कुछ माफ है 👫❤️"', lang: 'HI', likes: '24K', gradient: _gPink, category: 'Friends'),
  WishCard(id: 'f3', text: '"دوست وہ جو ہر مشکل میں ساتھ دے ✨"', lang: 'UR', likes: '17K', gradient: _gPurple, category: 'Friends'),
  WishCard(id: 'f4', text: '"Gli amici veri si contano sulle dita 🤝"', lang: 'IT', likes: '7K', gradient: _gGreen, category: 'Friends'),
  WishCard(id: 'f5', text: '"A real friend is one who walks in when the rest of the world walks out 💛"', lang: 'EN', likes: '29K', gradient: _gBlue, category: 'Friends'),
  WishCard(id: 'f6', text: '"दोस्तों के साथ जिंदगी हसीन है 🎉"', lang: 'HI', likes: '20K', gradient: _gOrange, category: 'Friends'),
  WishCard(id: 'f7', text: '"Friends are the chocolate chips in the cookie of life 🍪"', lang: 'EN', likes: '14K', gradient: _gPink, category: 'Friends'),
  WishCard(id: 'f8', text: '"دوستی ایک نعمت ہے جو ہر کسی کو نہیں ملتی ❤️"', lang: 'UR', likes: '12K', gradient: _gPurple, category: 'Friends'),
  WishCard(id: 'f9', text: '"Side by side or miles apart, real friends are always close at heart 💕"', lang: 'EN', likes: '22K', gradient: _gGreen, category: 'Friends'),
  WishCard(id: 'f10', text: '"Un amico è una luce nel buio 🌟"', lang: 'IT', likes: '6K', gradient: _gBlue, category: 'Friends'),
  WishCard(id: 'f11', text: '"सच्चे दोस्त नीरव होते हैं, हमेशा साथ देते हैं 🤗"', lang: 'HI', likes: '15K', gradient: _gPink, category: 'Friends'),

  // ===== GOOD NIGHT =====
  WishCard(id: 'gn1', text: '"Good night! Sweet dreams 🌙✨"', lang: 'EN', likes: '32K', gradient: _gPurple, category: 'GoodNight'),
  WishCard(id: 'gn2', text: '"शुभ रात्रि! मीठे सपने आए 🌙💫"', lang: 'HI', likes: '28K', gradient: _gBlue, category: 'GoodNight'),
  WishCard(id: 'gn3', text: '"شب بخیر! میٹھی نیند آئے 🌙"', lang: 'UR', likes: '21K', gradient: _gPink, category: 'GoodNight'),
  WishCard(id: 'gn4', text: '"Buonanotte amore mio, sogni d\'oro 💤❤️"', lang: 'IT', likes: '9K', gradient: _gPurple, category: 'GoodNight'),
  WishCard(id: 'gn5', text: '"Sleep tight! Tomorrow is a new adventure 🌙"', lang: 'EN', likes: '18K', gradient: _gOrange, category: 'GoodNight'),
  WishCard(id: 'gn6', text: '"रात की चांदनी आपको सुकून दे 🌙✨"', lang: 'HI', likes: '23K', gradient: _gGreen, category: 'GoodNight'),
  WishCard(id: 'gn7', text: '"تصبح على خير 🌙"', lang: 'AR', likes: '14K', gradient: _gBlue, category: 'GoodNight'),
  WishCard(id: 'gn8', text: '"May your dreams be sweeter than honey tonight 🍯🌙"', lang: 'EN', likes: '16K', gradient: _gPink, category: 'GoodNight'),

  // ===== BLESSINGS / RELIGIOUS =====
  WishCard(id: 'r1', text: '"May God bless you and keep you safe always 🙏"', lang: 'EN', likes: '26K', gradient: _gGreen, category: 'Blessings'),
  WishCard(id: 'r2', text: '"भगवान आपको हमेशा खुश रखे 🙏✨"', lang: 'HI', likes: '34K', gradient: _gOrange, category: 'Blessings'),
  WishCard(id: 'r3', text: '"اللہ آپ کو ہر خوشی نصیب کرے 🤲"', lang: 'UR', likes: '29K', gradient: _gPurple, category: 'Blessings'),
  WishCard(id: 'r4', text: '"اللهم بارك له ووفقه دائما 🤲"', lang: 'AR', likes: '20K', gradient: _gPink, category: 'Blessings'),
  WishCard(id: 'r5', text: '"Prayers and blessings sent your way today 🙏❤️"', lang: 'EN', likes: '15K', gradient: _gBlue, category: 'Blessings'),
  WishCard(id: 'r6', text: '"ईश्वर का आशीर्वाद आप पर बरसता रहे 🙏"', lang: 'HI', likes: '22K', gradient: _gGreen, category: 'Blessings'),
  WishCard(id: 'r7', text: '"Sending you all the love and blessings ❤️🌟"', lang: 'EN', likes: '17K', gradient: _gOrange, category: 'Blessings'),
];

List<Map<String, String>> getCategories(AppLocalizations s) => [
      {'label': s.wishCatTrending, 'value': 'Trending'},
      {'label': s.wishCatBirthday, 'value': 'Birthday'},
      {'label': s.wishCatEid, 'value': 'Eid'},
      {'label': s.wishCatDiwali, 'value': 'Diwali'},
      {'label': s.wishCatLove, 'value': 'Love'},
      {'label': s.wishCatShadi, 'value': 'Shadi'},
      {'label': s.wishCatMotivation, 'value': 'Motivation'},
      {'label': '🌅 Good Morning', 'value': 'GoodMorning'},
      {'label': '🌙 Good Night', 'value': 'GoodNight'},
      {'label': '👫 Friends', 'value': 'Friends'},
      {'label': '🙏 Blessings', 'value': 'Blessings'},
    ];
