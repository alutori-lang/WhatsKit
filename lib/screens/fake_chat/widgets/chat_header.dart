import 'package:flutter/material.dart';
import '../../../models/fake_chat.dart';
import '../../../theme/app_colors.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final FakeChat chat;
  final VoidCallback? onBack;
  final VoidCallback? onAvatarTap;

  const ChatHeader({
    super.key,
    required this.chat,
    this.onBack,
    this.onAvatarTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.waGreenDark,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                onPressed: onBack,
              ),
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: chat.avatarPreset.gradient,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    chat.initial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onAvatarTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.contactName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        chat.isTyping ? 'sta scrivendo...' : chat.statusText,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                          fontStyle: chat.isTyping ? FontStyle.italic : FontStyle.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.videocam, color: Colors.white, size: 22), onPressed: () {}),
              IconButton(icon: const Icon(Icons.call, color: Colors.white, size: 20), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert, color: Colors.white, size: 22), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
