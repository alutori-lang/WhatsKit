import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/app_colors.dart';
import '../../services/recents_storage.dart';

class DirectChatScreen extends StatefulWidget {
  const DirectChatScreen({super.key});

  @override
  State<DirectChatScreen> createState() => _DirectChatScreenState();
}

class _DirectChatScreenState extends State<DirectChatScreen> {
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  Country _selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
  );

  List<RecentChat> _recents = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecents();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadRecents() async {
    final list = await RecentsStorage.load();
    if (mounted) {
      setState(() {
        _recents = list;
        _loading = false;
      });
    }
  }

  Future<void> _openWhatsApp() async {
    final s = AppLocalizations.of(context)!;
    final phone = _phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.isEmpty) {
      _showError(s.dcEnterPhone);
      return;
    }
    final fullNumber = '${_selectedCountry.phoneCode}$phone';
    final messageText = _messageController.text.trim();
    final message = Uri.encodeComponent(messageText);
    final url = message.isEmpty
        ? 'https://wa.me/$fullNumber'
        : 'https://wa.me/$fullNumber?text=$message';

    HapticFeedback.lightImpact();

    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      await RecentsStorage.add(RecentChat(
        phoneCode: _selectedCountry.phoneCode,
        phoneNumber: phone,
        countryCode: _selectedCountry.countryCode,
        flag: _selectedCountry.flagEmoji,
        lastMessage: messageText.isEmpty ? null : messageText,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
      await _loadRecents();
    } else {
      if (mounted) _showError(s.dcWaNotInstalled);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(msg)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
      },
    );
  }

  void _useRecent(RecentChat recent) {
    setState(() {
      _phoneController.text = recent.phoneNumber;
      if (recent.lastMessage != null) {
        _messageController.text = recent.lastMessage!;
      }
      _selectedCountry = Country(
        phoneCode: recent.phoneCode,
        countryCode: recent.countryCode,
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: recent.countryCode,
        example: '',
        displayName: recent.countryCode,
        displayNameNoCountryCode: recent.countryCode,
        e164Key: '',
      );
    });
    HapticFeedback.selectionClick();
  }

  Future<void> _deleteRecent(RecentChat recent) async {
    HapticFeedback.mediumImpact();
    await RecentsStorage.remove(recent.fullNumber);
    await _loadRecents();
    if (!mounted) return;
    final s = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.dcRemovedSnack(recent.displayNumber)),
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _clearAllRecents() async {
    final s = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.dcClearAllTitle),
        content: Text(s.dcClearAllContent(_recents.length)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(s.commonCancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(s.commonDelete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await RecentsStorage.clear();
      await _loadRecents();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          s.dcTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (_recents.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: s.dcClearAllTooltip,
              onPressed: _clearAllRecents,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.waGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(color: AppColors.waGreen, width: 3),
              ),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${s.dcInfoTitle}\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.waGreenDark,
                    ),
                  ),
                  TextSpan(
                    text: s.dcInfoDesc,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            s.dcPhoneLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              InkWell(
                onTap: _showCountryPicker,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.bgPage,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountry.flagEmoji,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '+${_selectedCountry.phoneCode}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.expand_more, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: s.dcPhoneHint,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            s.dcMessageLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: s.dcMessageHint,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openWhatsApp,
            icon: const Icon(Icons.chat),
            label: Text(s.dcOpenInWA),
          ),
          const SizedBox(height: 24),
          if (!_loading) _buildRecentsSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildRecentsSection() {
    if (_recents.isEmpty) return const SizedBox.shrink();
    final s = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.dcRecentsHeader(_recents.length),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.waGreenDark,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                s.dcRecentsHint,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ..._recents.map((r) => _buildRecentTile(r)),
      ],
    );
  }

  Widget _buildRecentTile(RecentChat recent) {
    return InkWell(
      onTap: () => _useRecent(recent),
      onLongPress: () => _deleteRecent(recent),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.bgPage,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: AppColors.gradientWhatsApp,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                recent.flag,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          recent.displayNumber,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        recent.relativeTime(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (recent.lastMessage != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      recent.lastMessage!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
