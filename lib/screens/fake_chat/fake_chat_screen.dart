import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/coming_soon.dart';

class FakeChatScreen extends StatelessWidget {
  const FakeChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScaffold(
      title: 'Fake Chat Generator',
      emoji: '😂',
      description:
          'Crea chat WhatsApp finte per scherzi tra amici. UI 100% identica per screenshot realistici.',
      gradient: AppColors.gradientBlue,
      features: [
        'UI WhatsApp identica per screenshot realistici',
        'Personalizza nome contatto, foto profilo, status',
        'Spunte blu/grigie/singole · ora personalizzata',
        'Bubble inviati (verde) e ricevuti (bianco)',
        'Esporta come immagine condivisibile',
        'Marcato chiaramente come "parody/joke"',
      ],
    );
  }
}
