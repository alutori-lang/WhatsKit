import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../main.dart' show localeProvider;
import '../../services/locale_provider.dart';
import '../../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final currentLocaleCode = localeProvider.locale?.languageCode ??
        Localizations.localeOf(context).languageCode;
    final currentLanguage = LocaleProvider.localeNames[currentLocaleCode] ?? 'English';

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 16),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WhatsKit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      s.settingsSubtitle,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        _section(s.settingsPremium),
        _tile(
          icon: Icons.workspace_premium,
          iconColor: const Color(0xFFFFA000),
          title: s.settingsPassToPremium,
          subtitle: s.settingsPremiumDesc,
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
          onTap: () => _showSnack(context, s.settingsPremiumSoon),
        ),

        _section(s.settingsGeneral),
        _tile(
          icon: Icons.language,
          title: s.settingsLanguage,
          subtitle: '${LocaleProvider.localeFlags[currentLocaleCode] ?? '🌐'}  $currentLanguage',
          onTap: _showLanguagePicker,
        ),
        _tile(
          icon: Icons.dark_mode_outlined,
          title: s.settingsTheme,
          subtitle: s.settingsThemeLight,
          onTap: () => _showSnack(context, s.settingsThemeDarkSoon),
        ),
        _tile(
          icon: Icons.notifications_outlined,
          title: s.settingsNotifications,
          subtitle: s.settingsNotificationsDesc,
          onTap: () => _showSnack(context, s.settingsNotificationsSoon),
        ),

        _section(s.settingsShare),
        _tile(
          icon: Icons.share,
          iconColor: AppColors.waGreen,
          title: s.settingsShareApp,
          subtitle: s.settingsShareAppDesc,
          onTap: () => _shareApp(),
        ),
        _tile(
          icon: Icons.star_outline,
          iconColor: const Color(0xFFFFA000),
          title: s.settingsRate,
          subtitle: s.settingsRateDesc,
          onTap: () => _showSnack(context, s.settingsRateSoon),
        ),

        _section(s.settingsInfo),
        _tile(
          icon: Icons.privacy_tip_outlined,
          title: s.settingsPrivacy,
          onTap: () => _showSnack(context, s.settingsComingSoon),
        ),
        _tile(
          icon: Icons.description_outlined,
          title: s.settingsTerms,
          onTap: () => _showSnack(context, s.settingsComingSoon),
        ),
        _tile(
          icon: Icons.info_outline,
          title: s.settingsAbout,
          subtitle: s.settingsAboutDesc,
          onTap: () => _showAbout(context, s),
        ),

        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                s.settingsMadeWith,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                s.settingsDisclaimer,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.7), fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker() {
    final s = AppLocalizations.of(context)!;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  s.settingsLanguageDialogTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...LocaleProvider.supportedLocales.map((locale) {
                final code = locale.languageCode;
                final name = LocaleProvider.localeNames[code] ?? code;
                final flag = LocaleProvider.localeFlags[code] ?? '🌐';
                final selected = (localeProvider.locale?.languageCode ?? 'en') == code;
                return ListTile(
                  leading: Text(flag, style: const TextStyle(fontSize: 28)),
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  trailing: selected
                      ? const Icon(Icons.check_circle, color: AppColors.waGreen)
                      : null,
                  onTap: () async {
                    HapticFeedback.selectionClick();
                    await localeProvider.setLocale(locale);
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                );
              }),
            ],
          ),
        ),
      ),
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
    final url = Uri.parse('https://github.com/alutori-lang/WHATSAPPTOOLS');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showAbout(BuildContext context, AppLocalizations s) {
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
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            s.settingsDisclaimer,
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
        ),
      ],
    );
  }
}
