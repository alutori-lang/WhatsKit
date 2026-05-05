import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/fake_chat.dart';
import '../../theme/app_colors.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_header.dart';
import 'widgets/add_message_sheet.dart';
import 'widgets/contact_edit_sheet.dart';

class FakeChatScreen extends StatefulWidget {
  const FakeChatScreen({super.key});

  @override
  State<FakeChatScreen> createState() => _FakeChatScreenState();
}

class _FakeChatScreenState extends State<FakeChatScreen> {
  late FakeChat _chat;
  final _screenshotController = ScreenshotController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _chat = FakeChat.sample();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addMessage({bool isSent = true}) async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMessageSheet(defaultIsSent: isSent),
    );
    if (result is FakeMessage && result.text.isNotEmpty) {
      setState(() => _chat.messages.add(result));
      _scrollToBottom();
    }
  }

  Future<void> _editMessage(FakeMessage message) async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMessageSheet(existing: message),
    );
    if (result == 'delete') {
      setState(() => _chat.messages.removeWhere((m) => m.id == message.id));
    } else if (result is FakeMessage) {
      setState(() {
        final i = _chat.messages.indexWhere((m) => m.id == result.id);
        if (i >= 0) _chat.messages[i] = result;
      });
    }
  }

  Future<void> _editContact() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ContactEditSheet(chat: _chat),
    );
    if (result != null) {
      setState(() {
        _chat.contactName = result['name'] as String;
        _chat.statusText = result['status'] as String;
        _chat.avatarPreset = result['avatar'] as AvatarPreset;
        _chat.avatarPath = result['avatarPath'] as String?;
        _chat.isTyping = result['isTyping'] as bool;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _exportScreenshot() async {
    try {
      final bytes = await _screenshotController.capture(
        delay: const Duration(milliseconds: 50),
        pixelRatio: 3.0,
      );
      if (bytes == null) return;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/fake_chat_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      if (!mounted) return;
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Fake chat creata con WhatsKit (parody/joke)',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore export: $e')),
      );
    }
  }

  void _resetChat() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova chat'),
        content: const Text('Vuoi cancellare tutti i messaggi e ricominciare?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annulla')),
          TextButton(
            onPressed: () {
              setState(() {
                _chat = FakeChat(
                  contactName: 'Contatto',
                  avatarPreset: kAvatarPresets[1],
                  statusText: 'online',
                  messages: [],
                );
              });
              Navigator.pop(ctx);
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgChat,
      body: Column(
        children: [
          // Top bar (editor mode)
          Container(
            color: AppColors.bgPrimary,
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'Editor Fake Chat',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
                      tooltip: 'Reset',
                      onPressed: _resetChat,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: AppColors.waGreenDark),
                      tooltip: 'Esporta',
                      onPressed: _exportScreenshot,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // The chat preview (this is what gets screenshot)
          Expanded(
            child: Screenshot(
              controller: _screenshotController,
              child: Column(
                children: [
                  ChatHeader(
                    chat: _chat,
                    onBack: _editContact,
                    onAvatarTap: _editContact,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: AppColors.bgChat),
                      child: _chat.messages.isEmpty
                          ? _buildEmptyChat()
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              itemCount: _chat.messages.length,
                              itemBuilder: (ctx, i) {
                                final msg = _chat.messages[i];
                                return ChatBubble(
                                  message: msg,
                                  onTap: () => _editMessage(msg),
                                  onLongPress: () => _editMessage(msg),
                                );
                              },
                            ),
                    ),
                  ),
                  _buildFakeInputBar(),
                ],
              ),
            ),
          ),

          // Quick action bar (for editor)
          Container(
            decoration: const BoxDecoration(
              color: AppColors.bgPrimary,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: _quickAction(
                      icon: Icons.call_received,
                      label: 'Ricevuto',
                      color: const Color(0xFF6B7280),
                      onTap: () => _addMessage(isSent: false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _quickAction(
                      icon: Icons.call_made,
                      label: 'Inviato',
                      color: AppColors.waGreen,
                      onTap: () => _addMessage(isSent: true),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_outline, color: Color(0xFFD4A60E), size: 28),
              SizedBox(height: 8),
              Text(
                'Tap "Ricevuto" o "Inviato" per aggiungere messaggi 👇',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF8B6F19),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFakeInputBar() {
    return Container(
      color: AppColors.bgPage,
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined, color: AppColors.textSecondary, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Messaggio',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                    ),
                  ),
                  Icon(Icons.attach_file, color: AppColors.textSecondary, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 22),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.waGreenDark,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
