import 'package:flutter/material.dart';
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

const kAllTools = <ToolItem>[
  ToolItem(
    id: 'sticker_maker',
    title: 'Sticker Maker',
    subtitle: 'Crea sticker da foto · Rimuovi sfondo',
    emoji: '🎨',
    gradient: AppColors.gradientPink,
    badge: 'AI ✨',
    route: '/sticker',
  ),
  ToolItem(
    id: 'direct_chat',
    title: 'Direct Chat',
    subtitle: 'Chatta senza salvare il numero',
    emoji: '💬',
    gradient: AppColors.gradientGreen,
    badge: '⚡',
    route: '/direct-chat',
  ),
  ToolItem(
    id: 'text_formatter',
    title: 'Text Formatter',
    subtitle: '𝓕𝓪𝓷𝓬𝔂 𝓕𝓸𝓷𝓽𝓼 · Bold · Italic',
    emoji: '✨',
    gradient: AppColors.gradientPurple,
    badge: '100+',
    route: '/text',
  ),
  ToolItem(
    id: 'wishes_maker',
    title: 'Wishes & Status',
    subtitle: 'Eid · Diwali · Birthday · Love',
    emoji: '🎂',
    gradient: AppColors.gradientOrange,
    badge: 'NEW',
    route: '/wishes',
  ),
  ToolItem(
    id: 'fake_chat',
    title: 'Fake Chat Generator',
    subtitle: 'Crea chat finte per scherzi',
    emoji: '😂',
    gradient: AppColors.gradientBlue,
    badge: '😆',
    route: '/fake-chat',
  ),
];
