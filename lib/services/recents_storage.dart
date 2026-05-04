import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RecentChat {
  final String phoneCode;
  final String phoneNumber;
  final String countryCode;
  final String flag;
  final String? lastMessage;
  final int timestamp;

  RecentChat({
    required this.phoneCode,
    required this.phoneNumber,
    required this.countryCode,
    required this.flag,
    this.lastMessage,
    required this.timestamp,
  });

  String get displayNumber => '+$phoneCode $phoneNumber';
  String get fullNumber => '$phoneCode${phoneNumber.replaceAll(RegExp(r'[^0-9]'), '')}';

  Map<String, dynamic> toJson() => {
        'phoneCode': phoneCode,
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
        'flag': flag,
        'lastMessage': lastMessage,
        'timestamp': timestamp,
      };

  factory RecentChat.fromJson(Map<String, dynamic> json) => RecentChat(
        phoneCode: json['phoneCode'] as String,
        phoneNumber: json['phoneNumber'] as String,
        countryCode: json['countryCode'] as String,
        flag: json['flag'] as String,
        lastMessage: json['lastMessage'] as String?,
        timestamp: json['timestamp'] as int,
      );

  String relativeTime() {
    final now = DateTime.now();
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'ora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    if (diff.inDays < 2) return 'ieri';
    if (diff.inDays < 7) return '${diff.inDays} gg';
    return '${dt.day}/${dt.month}';
  }
}

class RecentsStorage {
  static const _key = 'direct_chat_recents';
  static const _maxItems = 20;

  static Future<List<RecentChat>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw
        .map((s) {
          try {
            return RecentChat.fromJson(jsonDecode(s) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<RecentChat>()
        .toList();
  }

  static Future<void> add(RecentChat chat) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await load();
    list.removeWhere((c) => c.fullNumber == chat.fullNumber);
    list.insert(0, chat);
    if (list.length > _maxItems) list.removeRange(_maxItems, list.length);
    await prefs.setStringList(
      _key,
      list.map((c) => jsonEncode(c.toJson())).toList(),
    );
  }

  static Future<void> remove(String fullNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await load();
    list.removeWhere((c) => c.fullNumber == fullNumber);
    await prefs.setStringList(
      _key,
      list.map((c) => jsonEncode(c.toJson())).toList(),
    );
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
