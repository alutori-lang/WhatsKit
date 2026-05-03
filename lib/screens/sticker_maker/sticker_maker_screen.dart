import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/coming_soon.dart';

class StickerMakerScreen extends StatelessWidget {
  const StickerMakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScaffold(
      title: 'Sticker Maker',
      emoji: '🎨',
      description:
          'Trasforma qualsiasi foto in uno sticker WhatsApp. La nostra AI rimuove lo sfondo automaticamente.',
      gradient: AppColors.gradientPink,
      features: [
        'Rimozione sfondo AI con Gemini Vision',
        'Crea sticker da foto, galleria o testo',
        'Pacchetti sticker pronti per WhatsApp',
        'Sticker animati (Premium)',
        'Esporta direttamente a WhatsApp',
      ],
    );
  }
}
