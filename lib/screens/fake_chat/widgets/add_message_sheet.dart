import 'package:flutter/material.dart';
import '../../../models/fake_chat.dart';
import '../../../theme/app_colors.dart';

class AddMessageSheet extends StatefulWidget {
  final FakeMessage? existing;
  final bool defaultIsSent;
  const AddMessageSheet({
    super.key,
    this.existing,
    this.defaultIsSent = true,
  });

  @override
  State<AddMessageSheet> createState() => _AddMessageSheetState();
}

class _AddMessageSheetState extends State<AddMessageSheet> {
  late final TextEditingController _textController;
  late final TextEditingController _timeController;
  late bool _isSent;
  late ReadStatus _status;

  @override
  void initState() {
    super.initState();
    final m = widget.existing;
    _textController = TextEditingController(text: m?.text ?? '');
    _timeController = TextEditingController(
      text: m?.time ?? _now(),
    );
    _isSent = m?.isSent ?? widget.defaultIsSent;
    _status = m?.status ?? ReadStatus.read;
  }

  String _now() {
    final now = TimeOfDay.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void dispose() {
    _textController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _save() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    final result = FakeMessage(
      id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isSent: _isSent,
      time: _timeController.text.trim().isEmpty ? _now() : _timeController.text.trim(),
      status: _status,
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
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
                Text(
                  isEdit ? 'Modifica messaggio' : 'Nuovo messaggio',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                // Sent / Received toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.bgPage,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _toggle(label: 'Ricevuto', selected: !_isSent, onTap: () => setState(() => _isSent = false))),
                      Expanded(child: _toggle(label: 'Inviato', selected: _isSent, onTap: () => setState(() => _isSent = true))),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Message text
                const Text('TESTO', style: _labelStyle),
                const SizedBox(height: 6),
                TextField(
                  controller: _textController,
                  maxLines: 4,
                  minLines: 2,
                  autofocus: !isEdit,
                  decoration: const InputDecoration(
                    hintText: 'Scrivi il messaggio...',
                  ),
                ),
                const SizedBox(height: 16),

                // Time + Status row
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ORA', style: _labelStyle),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _timeController,
                            decoration: const InputDecoration(
                              hintText: '10:24',
                              prefixIcon: Icon(Icons.access_time, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_isSent) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SPUNTE', style: _labelStyle),
                            const SizedBox(height: 6),
                            DropdownButtonFormField<ReadStatus>(
                              initialValue: _status,
                              isExpanded: true,
                              items: ReadStatus.values
                                  .map((s) => DropdownMenuItem(
                                        value: s,
                                        child: Row(
                                          children: [
                                            Icon(s.icon, color: s.color, size: 18),
                                            const SizedBox(width: 8),
                                            Text(s.label, style: const TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (v) => setState(() => _status = v ?? ReadStatus.read),
                              decoration: const InputDecoration(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: _save,
                  icon: Icon(isEdit ? Icons.check : Icons.add),
                  label: Text(isEdit ? 'Salva' : 'Aggiungi'),
                ),
                if (isEdit) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop('delete'),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('Elimina', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggle({required String label, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.waGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
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
