import 'package:flutter/material.dart';
import '../../../models/fake_chat.dart';
import '../../../theme/app_colors.dart';

class ContactEditSheet extends StatefulWidget {
  final FakeChat chat;
  const ContactEditSheet({super.key, required this.chat});

  @override
  State<ContactEditSheet> createState() => _ContactEditSheetState();
}

class _ContactEditSheetState extends State<ContactEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _statusController;
  late AvatarPreset _selectedAvatar;
  late bool _isTyping;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chat.contactName);
    _statusController = TextEditingController(text: widget.chat.statusText);
    _selectedAvatar = widget.chat.avatarPreset;
    _isTyping = widget.chat.isTyping;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop({
      'name': _nameController.text.trim().isEmpty ? '?' : _nameController.text.trim(),
      'status': _statusController.text.trim(),
      'avatar': _selectedAvatar,
      'isTyping': _isTyping,
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.bgPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Modifica contatto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('NOME CONTATTO', style: _labelStyle),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'es: Sarah, Mom, Boss',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('STATO', style: _labelStyle),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _statusController,
                        decoration: const InputDecoration(
                          hintText: 'online, ultimo accesso oggi alle 10:23',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _quickStatus('online'),
                          _quickStatus('ultimo accesso oggi alle 10:23'),
                          _quickStatus('ultimo accesso ieri alle 23:45'),
                          _quickStatus('ultimo accesso poco fa'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.bgPage,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Mostra "sta scrivendo..."',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Switch(
                        value: _isTyping,
                        activeThumbColor: AppColors.waGreen,
                        onChanged: (v) => setState(() => _isTyping = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('AVATAR (COLORE)', style: _labelStyle),
                const SizedBox(height: 10),
                Row(
                  children: kAvatarPresets.map((preset) {
                    final selected = preset.label == _selectedAvatar.label;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedAvatar = preset),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: preset.gradient,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected ? AppColors.waGreenDark : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: selected
                              ? const Icon(Icons.check, color: Colors.white, size: 22)
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Salva'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickStatus(String text) {
    return GestureDetector(
      onTap: () => setState(() => _statusController.text = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.bgPage,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

const _labelStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: AppColors.textSecondary,
  letterSpacing: 0.5,
);
