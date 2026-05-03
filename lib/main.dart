import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';
import 'screens/home/home_screen.dart';
import 'screens/sticker_maker/sticker_maker_screen.dart';
import 'screens/direct_chat/direct_chat_screen.dart';
import 'screens/text_formatter/text_formatter_screen.dart';
import 'screens/wishes_maker/wishes_maker_screen.dart';
import 'screens/fake_chat/fake_chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.bgPrimary,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const WhatsKitApp());
}

class WhatsKitApp extends StatelessWidget {
  const WhatsKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsKit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/sticker': (_) => const StickerMakerScreen(),
        '/direct-chat': (_) => const DirectChatScreen(),
        '/text': (_) => const TextFormatterScreen(),
        '/wishes': (_) => const WishesMakerScreen(),
        '/fake-chat': (_) => const FakeChatScreen(),
      },
    );
  }
}
