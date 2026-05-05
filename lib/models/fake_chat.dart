import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum ReadStatus { sent, delivered, read }

extension ReadStatusUI on ReadStatus {
  IconData get icon {
    switch (this) {
      case ReadStatus.sent:
        return Icons.check;
      case ReadStatus.delivered:
        return Icons.done_all;
      case ReadStatus.read:
        return Icons.done_all;
    }
  }

  Color get color {
    switch (this) {
      case ReadStatus.sent:
      case ReadStatus.delivered:
        return AppColors.textSecondary;
      case ReadStatus.read:
        return AppColors.waBlue;
    }
  }

  String get label {
    switch (this) {
      case ReadStatus.sent:
        return 'Inviato';
      case ReadStatus.delivered:
        return 'Consegnato';
      case ReadStatus.read:
        return 'Letto';
    }
  }
}

class FakeMessage {
  final String id;
  String text;
  bool isSent;
  String time;
  ReadStatus status;

  FakeMessage({
    required this.id,
    required this.text,
    required this.isSent,
    required this.time,
    this.status = ReadStatus.read,
  });
}

class AvatarPreset {
  final String label;
  final LinearGradient gradient;
  const AvatarPreset(this.label, this.gradient);
}

const kAvatarPresets = <AvatarPreset>[
  AvatarPreset('Pink', AppColors.gradientPink),
  AvatarPreset('Green', AppColors.gradientGreen),
  AvatarPreset('Purple', AppColors.gradientPurple),
  AvatarPreset('Orange', AppColors.gradientOrange),
  AvatarPreset('Blue', AppColors.gradientBlue),
];

class FakeChat {
  String contactName;
  AvatarPreset avatarPreset;
  String? avatarPath; // path to custom avatar image (null = use gradient)
  String statusText;
  bool isTyping;
  List<FakeMessage> messages;

  FakeChat({
    required this.contactName,
    required this.avatarPreset,
    required this.statusText,
    this.avatarPath,
    this.isTyping = false,
    List<FakeMessage>? messages,
  }) : messages = messages ?? [];

  String get initial {
    final trimmed = contactName.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.characters.first.toUpperCase();
  }

  static FakeChat sample() {
    return FakeChat(
      contactName: 'Sarah ❤️',
      avatarPreset: kAvatarPresets[0],
      statusText: 'online',
      messages: [
        FakeMessage(id: '1', text: 'Hey! Where are you? 🥺', isSent: false, time: '10:23'),
        FakeMessage(id: '2', text: 'On my way babe! 5 min', isSent: true, time: '10:24', status: ReadStatus.read),
        FakeMessage(id: '3', text: 'Okay see you soon ❤️', isSent: false, time: '10:24'),
        FakeMessage(id: '4', text: 'Love you so much 😘', isSent: true, time: '10:25', status: ReadStatus.read),
        FakeMessage(id: '5', text: 'I have a surprise for you 🎁', isSent: false, time: '10:26'),
      ],
    );
  }
}
