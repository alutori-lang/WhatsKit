import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 16),
        // Header card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.gradientWhatsApp,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.handyman, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WhatsKit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'v1.0.0 · 5 strumenti per WhatsApp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        _section('PREMIUM'),
        _tile(
          icon: Icons.workspace_premium,
          iconColor: const Color(0xFFFFA000),
          title: 'Passa a Premium',
          subtitle: 'Rimuovi pubblicità + sticker pack esclusivi',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.waGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '€2.99',
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => _showSnack(context, 'Premium in arrivo!'),
        ),

        _section('GENERALE'),
        _tile(
          icon: Icons.language,
          title: 'Lingua',
          subtitle: 'Italiano',
          onTap: () => _showSnack(context, 'Multi-lingua in arrivo (EN/HI/UR/IT)'),
        ),
        _tile(
          icon: Icons.dark_mode_outlined,
          title: 'Tema',
          subtitle: 'Chiaro',
          onTap: () => _showSnack(context, 'Dark mode in arrivo!'),
        ),
        _tile(
          icon: Icons.notifications_outlined,
          title: 'Notifiche',
          subtitle: 'Promemoria status compleanni',
          onTap: () => _showSnack(context, 'Notifiche in arrivo!'),
        ),

        _section('CONDIVIDI'),
        _tile(
          icon: Icons.share,
          iconColor: AppColors.waGreen,
          title: 'Consiglia ad un amico',
          subtitle: 'Condividi WhatsKit',
          onTap: () => _shareApp(),
        ),
        _tile(
          icon: Icons.star_outline,
          iconColor: const Color(0xFFFFA000),
          title: 'Lascia una recensione',
          subtitle: 'Supportaci su Play Store',
          onTap: () => _showSnack(context, 'Disponibile dopo pubblicazione store'),
        ),

        _section('INFO'),
        _tile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () => _showSnack(context, 'In arrivo'),
        ),
        _tile(
          icon: Icons.description_outlined,
          title: 'Termini di servizio',
          onTap: () => _showSnack(context, 'In arrivo'),
        ),
        _tile(
          icon: Icons.info_outline,
          title: 'Informazioni',
          subtitle: 'WhatsKit v1.0.0',
          onTap: () => _showAbout(context),
        ),

        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Made with 💚 by alutori',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                'WhatsKit non è affiliato con WhatsApp Inc. o Meta',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.7), fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _section(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.waGreenDark,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.waGreenDark).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor ?? AppColors.waGreenDark, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _shareApp() async {
    final url = Uri.parse('https://github.com/alutori-lang/WhatsKit');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'WhatsKit',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.gradientWhatsApp,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.handyman, color: Colors.white, size: 28),
      ),
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'WhatsKit raccoglie 5 strumenti utili per WhatsApp in un\'unica app:\n\n'
            '• Sticker Maker con AI\n'
            '• Direct Chat senza salvare numeri\n'
            '• Text Formatter con 19+ font fancy\n'
            '• Wishes & Status Maker\n'
            '• Fake Chat Generator (parody)\n\n'
            'WhatsKit non è affiliato con WhatsApp Inc. o Meta.',
            style: TextStyle(fontSize: 13, height: 1.5),
          ),
        ),
      ],
    );
  }
}
