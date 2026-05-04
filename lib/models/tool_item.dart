import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';

class ToolItem {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final LinearGradient gradient;
  final String? badge;
  final String route;

  const ToolItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
    required this.route,
    this.badge,
  });
}

List<ToolItem> getAllTools(AppLocalizations s) => [
      ToolItem(
        id: 'sticker_maker',
        title: s.toolStickerMaker,
        subtitle: s.toolStickerMakerDesc,
        emoji: '🎨',
        gradient: AppColors.gradientPink,
        badge: s.toolStickerMakerBadge,
        route: '/sticker',
      ),
      ToolItem(
        id: 'direct_chat',
        title: s.toolDirectChat,
        subtitle: s.toolDirectChatDesc,
        emoji: '💬',
        gradient: AppColors.gradientGreen,
        badge: s.toolDirectChatBadge,
        route: '/direct-chat',
      ),
      ToolItem(
        id: 'text_formatter',
        title: s.toolTextFormatter,
        subtitle: s.toolTextFormatterDesc,
        emoji: '✨',
        gradient: AppColors.gradientPurple,
        badge: s.toolTextFormatterBadge,
        route: '/text',
      ),
      ToolItem(
        id: 'wishes_maker',
        title: s.toolWishesMaker,
        subtitle: s.toolWishesMakerDesc,
        emoji: '🎂',
        gradient: AppColors.gradientOrange,
        badge: s.toolWishesMakerBadge,
        route: '/wishes',
      ),
      ToolItem(
        id: 'fake_chat',
        title: s.toolFakeChat,
        subtitle: s.toolFakeChatDesc,
        emoji: '😂',
        gradient: AppColors.gradientBlue,
        badge: s.toolFakeChatBadge,
        route: '/fake-chat',
      ),
    ];
