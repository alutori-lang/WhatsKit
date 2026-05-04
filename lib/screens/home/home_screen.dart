import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/tool_item.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tool_list_item.dart';
import '../sticker_maker/sticker_maker_screen.dart';
import '../wishes_maker/wishes_maker_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: _currentIndex == 0
            ? [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _ToolsTab(),
          StickerMakerScreen(embedded: true),
          WishesMakerScreen(embedded: true),
          SettingsScreen(),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed('/sticker'),
              child: const Icon(Icons.edit, size: 22),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          HapticFeedback.selectionClick();
          setState(() => _currentIndex = i);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.handyman_outlined), activeIcon: Icon(Icons.handyman), label: 'Tools'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions_outlined), activeIcon: Icon(Icons.emoji_emotions), label: 'Stickers'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Wishes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  static const _titles = ['WhatsKit', 'Sticker Maker', 'Wishes & Status', 'Impostazioni'];
}

class _ToolsTab extends StatelessWidget {
  const _ToolsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildSectionHeader('STRUMENTI WHATSAPP'),
              ...kAllTools.map((tool) => ToolListItem(
                    tool: tool,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pushNamed(tool.route);
                    },
                  )),
              _buildPremiumBanner(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgPage,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          SizedBox(width: 12),
          Text(
            'Cerca strumenti...',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.waGreenDark,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.waGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(color: AppColors.waGreen, width: 3),
        ),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '💎 Premium',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.waGreenDark,
              ),
            ),
            TextSpan(
              text: ' · Rimuovi pubblicità + sticker pack esclusivi · €2.99',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
