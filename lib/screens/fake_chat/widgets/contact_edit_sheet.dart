import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late String? _avatarPath;
  late bool _isTyping;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chat.contactName);
    _statusController = TextEditingController(text: widget.chat.statusText);
    _selectedAvatar = widget.chat.avatarPreset;
    _avatarPath = widget.chat.avatarPath;
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
      'avatarPath': _avatarPath,
      'isTyping': _isTyping,
    });
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 90,
      maxWidth: 512,
    );
    if (picked != null) {
      setState(() => _avatarPath = picked.path);
    }
  }

  void _showPhotoSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: AppColors.gradientPink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
                title: const Text('Scatta foto'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: AppColors.gradientPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.photo_library, color: Colors.white),
                ),
                title: const Text('Galleria'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickPhoto(ImageSource.gallery);
                },
              ),
              if (_avatarPath != null)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  title: const Text('Rimuovi foto', style: TextStyle(color: Colors.red)),
                  subtitle: const Text('Torna al colore'),
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() => _avatarPath = null);
                  },
                ),
            ],
          ),
        ),
      ),
    );
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

                // Avatar preview + photo picker
                Center(
                  child: GestureDetector(
                    onTap: _showPhotoSourcePicker,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: _avatarPath != null
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(File(_avatarPath!)),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : BoxDecoration(
                                  gradient: _selectedAvatar.gradient,
                                  shape: BoxShape.circle,
                                ),
                          alignment: Alignment.center,
                          child: _avatarPath == null
                              ? Text(
                                  _nameController.text.isEmpty
                                      ? '?'
                                      : _nameController.text.characters.first.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.waGreen,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Color(0x33000000), blurRadius: 4),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: TextButton.icon(
                    onPressed: _showPhotoSourcePicker,
                    icon: Icon(
                      _avatarPath == null ? Icons.add_a_photo : Icons.swap_horiz,
                      size: 16,
                    ),
                    label: Text(_avatarPath == null ? 'Carica foto' : 'Cambia foto'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.waGreenDark,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Text('NOME CONTATTO', style: _labelStyle),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'es: Sarah, Mom, Boss',
                  ),
                  onChanged: (_) => setState(() {}),
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
                Text(
                  _avatarPath != null
                      ? 'AVATAR (COLORE) — non visibile, foto attiva'
                      : 'AVATAR (COLORE)',
                  style: _labelStyle,
                ),
                const SizedBox(height: 10),
                Opacity(
                  opacity: _avatarPath != null ? 0.4 : 1.0,
                  child: Row(
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
