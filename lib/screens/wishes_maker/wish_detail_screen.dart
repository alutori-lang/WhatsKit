import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/wish_card.dart';
import '../../theme/app_colors.dart';

class WishDetailScreen extends StatefulWidget {
  final WishCard? wish;
  final bool createMode;
  const WishDetailScreen({super.key, this.wish, this.createMode = false})
      : assert(wish != null || createMode == true);

  @override
  State<WishDetailScreen> createState() => _WishDetailScreenState();
}

class _WishDetailScreenState extends State<WishDetailScreen> {
  late TextEditingController _textController;
  late LinearGradient _selectedGradient;
  final _screenshotController = ScreenshotController();
  double _fontSize = 22;

  static const _gradientOptions = [
    AppColors.gradientPink,
    AppColors.gradientGreen,
    AppColors.gradientPurple,
    AppColors.gradientOrange,
    AppColors.gradientBlue,
    AppColors.gradientWhatsApp,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.createMode) {
      _textController = TextEditingController();
      _selectedGradient = AppColors.gradientPink;
    } else {
      _textController = TextEditingController(text: widget.wish!.text);
      _selectedGradient = widget.wish!.gradient;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _shareAsImage() async {
    HapticFeedback.lightImpact();
    try {
      final bytes = await _screenshotController.capture(
        delay: const Duration(milliseconds: 50),
        pixelRatio: 3.0,
      );
      if (bytes == null) return;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/wish_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      if (!mounted) return;
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Created with WhatsKit ✨',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore: $e')),
      );
    }
  }

  Future<void> _shareAsText() async {
    HapticFeedback.selectionClick();
    await Share.share(_textController.text);
  }

  Future<void> _copy() async {
    HapticFeedback.lightImpact();
    await Clipboard.setData(ClipboardData(text: _textController.text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Copiato!'),
          ],
        ),
        backgroundColor: AppColors.waGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.createMode ? 'Crea Status' : 'Personalizza',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            onPressed: _copy,
            tooltip: 'Copia testo',
          ),
        ],
      ),
      body: Column(
        children: [
          // Preview area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Screenshot(
                    controller: _screenshotController,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: _selectedGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(32),
                      child: Stack(
                        children: [
                          if (!widget.createMode)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.wish!.lang,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              _textController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                                shadows: const [
                                  Shadow(
                                    color: Color(0x33000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            child: Row(
                              children: [
                                Icon(Icons.auto_awesome, color: Colors.white70, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  'WhatsKit',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Edit panel
          Container(
            decoration: const BoxDecoration(
              color: AppColors.bgPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, -2)),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('TESTO', style: _labelStyle),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _textController,
                    maxLines: 3,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Modifica il messaggio...',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('GRANDEZZA', style: _labelStyle),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 14,
                          max: 32,
                          activeColor: AppColors.waGreen,
                          onChanged: (v) => setState(() => _fontSize = v),
                        ),
                      ),
                      Text('${_fontSize.round()}px', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('COLORE', style: _labelStyle),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _gradientOptions.map((g) {
                        final selected = g == _selectedGradient;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedGradient = g),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: g,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? AppColors.waGreenDark : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: selected
                                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _shareAsText,
                          icon: const Icon(Icons.text_fields, size: 18),
                          label: const Text('Testo'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.divider),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _shareAsImage,
                          icon: const Icon(Icons.image),
                          label: const Text('Condividi immagine'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
