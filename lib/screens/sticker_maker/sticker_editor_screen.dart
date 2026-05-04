import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/app_colors.dart';
import '../../services/mlkit_service.dart';
import '../../services/sticker_storage.dart';

class StickerEditorScreen extends StatefulWidget {
  final String? imagePath;
  final File? existingFile;

  const StickerEditorScreen({super.key, this.imagePath, this.existingFile})
      : assert(imagePath != null || existingFile != null);

  @override
  State<StickerEditorScreen> createState() => _StickerEditorScreenState();
}

class _StickerEditorScreenState extends State<StickerEditorScreen> {
  Uint8List? _originalBytes;
  Uint8List? _processedBytes;
  bool _processing = false;
  bool _saved = false;
  String? _error;
  late final bool _isExisting;

  @override
  void initState() {
    super.initState();
    _isExisting = widget.existingFile != null;
    _loadInitialImage();
  }

  Future<void> _loadInitialImage() async {
    if (_isExisting) {
      final bytes = await widget.existingFile!.readAsBytes();
      setState(() {
        _processedBytes = bytes;
        _saved = true;
      });
    } else {
      final file = File(widget.imagePath!);
      final bytes = await file.readAsBytes();
      setState(() => _originalBytes = bytes);
    }
  }

  Future<void> _removeBackground() async {
    if (widget.imagePath == null) return;

    setState(() {
      _processing = true;
      _error = null;
    });

    try {
      final result = await MLKitService.removeBackground(widget.imagePath!);
      setState(() {
        _processedBytes = result;
        _processing = false;
      });
    } catch (e) {
      setState(() {
        _processing = false;
        _error = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _saveSticker() async {
    if (_processedBytes == null) return;
    final file = await StickerStorage.save(_processedBytes!);
    if (mounted) {
      setState(() => _saved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text('Sticker salvato! ${file.path.split('/').last}'),
            ],
          ),
          backgroundColor: AppColors.waGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _shareSticker() async {
    if (_processedBytes == null) return;
    File file;
    if (_saved && widget.existingFile != null) {
      file = widget.existingFile!;
    } else {
      file = await StickerStorage.save(_processedBytes!);
    }
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Sticker creato con WhatsKit ✨',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(_saved),
        ),
        title: Text(
          _isExisting ? 'Sticker' : (_processedBytes != null ? 'Risultato' : 'Nuovo Sticker'),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (_processedBytes != null)
            IconButton(icon: const Icon(Icons.share), onPressed: _shareSticker),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _buildPreview(),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_processing) {
      return _buildProcessingState();
    }
    if (_error != null) {
      return _buildErrorState();
    }
    if (_processedBytes != null) {
      return _buildResultPreview();
    }
    if (_originalBytes != null) {
      return _buildOriginalPreview();
    }
    return const Center(child: CircularProgressIndicator(color: AppColors.waGreen));
  }

  Widget _buildOriginalPreview() {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.memory(
              _originalBytes!,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.waGreen.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.waGreen.withValues(alpha: 0.3)),
          ),
          child: const Row(
            children: [
              Icon(Icons.tips_and_updates, color: AppColors.waGreenDark, size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Per i risultati migliori usa foto con un soggetto chiaro e ben illuminato.',
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultPreview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8F8F8), Color(0xFFE8E8E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Checkered transparency pattern
            CustomPaint(
              size: Size.infinite,
              painter: _CheckerPainter(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.memory(
                _processedBytes!,
                fit: BoxFit.contain,
              ),
            ),
            if (_saved)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.waGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'SALVATO',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppColors.gradientWhatsApp,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '✨ AI al lavoro...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sto rimuovendo lo sfondo dalla tua foto.\nPuò richiedere 5-15 secondi.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 50),
          const SizedBox(height: 12),
          const Text(
            'Ops! Qualcosa è andato storto',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: SelectableText(
                  _error ?? 'Errore sconosciuto',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    height: 1.4,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _error ?? ''));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Errore copiato'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('Copia errore'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _removeBackground,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Riprova'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.bgPrimary,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          if (_processedBytes != null && !_isExisting && !_saved) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _processedBytes = null;
                    _error = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.divider),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Riprova'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: _saveSticker,
                icon: const Icon(Icons.save_alt),
                label: const Text('Salva sticker'),
              ),
            ),
          ] else if (_processedBytes != null) ...[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _shareSticker,
                icon: const Icon(Icons.share),
                label: const Text('Condividi su WhatsApp'),
              ),
            ),
          ] else if (_originalBytes != null && !_processing) ...[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _removeBackground,
                icon: const Icon(Icons.auto_fix_high),
                label: const Text('Rimuovi sfondo AI'),
              ),
            ),
          ] else ...[
            const SizedBox(height: 50),
          ],
        ],
      ),
    );
  }
}

class _CheckerPainter extends CustomPainter {
  static const double tile = 16;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rows = (size.height / tile).ceil();
    final cols = (size.width / tile).ceil();
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        paint.color = (r + c).isEven ? const Color(0xFFFAFAFA) : const Color(0xFFE5E5E5);
        canvas.drawRect(
          Rect.fromLTWH(c * tile, r * tile, tile, tile),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
