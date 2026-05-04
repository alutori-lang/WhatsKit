// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WhatsKit';

  @override
  String get searchTools => 'Search tools...';

  @override
  String get toolsHeader => 'WHATSAPP TOOLS';

  @override
  String get premiumBadge => '💎 Premium';

  @override
  String get premiumDesc => ' · Remove ads + exclusive sticker packs · €2.99';

  @override
  String get tabTools => 'Tools';

  @override
  String get tabStickers => 'Stickers';

  @override
  String get tabWishes => 'Wishes';

  @override
  String get tabSettings => 'Settings';

  @override
  String get toolStickerMaker => 'Sticker Maker';

  @override
  String get toolStickerMakerDesc =>
      'Create stickers from photos · Remove background';

  @override
  String get toolStickerMakerBadge => 'AI ✨';

  @override
  String get toolDirectChat => 'Direct Chat';

  @override
  String get toolDirectChatDesc => 'Chat without saving the number';

  @override
  String get toolDirectChatBadge => '⚡';

  @override
  String get toolTextFormatter => 'Text Formatter';

  @override
  String get toolTextFormatterDesc => '𝓕𝓪𝓷𝓬𝔂 𝓕𝓸𝓷𝓽𝓼 · Bold · Italic';

  @override
  String get toolTextFormatterBadge => '100+';

  @override
  String get toolWishesMaker => 'Wishes & Status';

  @override
  String get toolWishesMakerDesc => 'Eid · Diwali · Birthday · Love';

  @override
  String get toolWishesMakerBadge => 'NEW';

  @override
  String get toolFakeChat => 'Fake Chat Generator';

  @override
  String get toolFakeChatDesc => 'Create fake chats for jokes';

  @override
  String get toolFakeChatBadge => '😆';

  @override
  String get stickerHeroTitle => 'AI Background Remove';

  @override
  String get stickerHeroDesc =>
      'Upload a photo · AI removes the background automatically · Create stickers ready for WhatsApp';

  @override
  String get stickerStartNow => 'Start now';

  @override
  String get stickerMine => 'MY STICKERS';

  @override
  String get stickerEmptyTitle => 'No stickers yet';

  @override
  String get stickerEmptyDesc =>
      'Tap \"Start now\" to create your first AI sticker';

  @override
  String get stickerSourceTitle => 'Choose source';

  @override
  String get stickerSourceCamera => 'Take photo';

  @override
  String get stickerSourceCameraDesc => 'Use the camera';

  @override
  String get stickerSourceGallery => 'Gallery';

  @override
  String get stickerSourceGalleryDesc => 'Pick an existing photo';

  @override
  String get stickerDeleteTitle => 'Delete sticker';

  @override
  String get stickerDeleteContent =>
      'Do you really want to delete this sticker?';

  @override
  String get editorNewSticker => 'New Sticker';

  @override
  String get editorResult => 'Result';

  @override
  String get editorSticker => 'Sticker';

  @override
  String get editorRemoveBgAi => 'Remove background AI';

  @override
  String get editorSaveSticker => 'Save sticker';

  @override
  String get editorRetry => 'Retry';

  @override
  String get editorShareToWA => 'Share to WhatsApp';

  @override
  String get editorProcessingTitle => '✨ AI at work...';

  @override
  String get editorProcessingDesc =>
      'Removing background from your photo.\nMay take 5-15 seconds.';

  @override
  String get editorErrorTitle => 'Oops! Something went wrong';

  @override
  String get editorTipText =>
      'For best results use photos with a clear, well-lit subject.';

  @override
  String get editorSavedSnack => 'Sticker saved!';

  @override
  String get editorSavedBadge => 'SAVED';

  @override
  String get dcTitle => 'Direct Chat';

  @override
  String get dcInfoTitle => '⚡ No contacts needed';

  @override
  String get dcInfoDesc =>
      'Chat on WhatsApp with any number without adding it to your contacts.';

  @override
  String get dcPhoneLabel => 'PHONE NUMBER';

  @override
  String get dcPhoneHint => '98765 43210';

  @override
  String get dcMessageLabel => 'MESSAGE (OPTIONAL)';

  @override
  String get dcMessageHint => 'Hi! I wanted to ask...';

  @override
  String get dcOpenInWA => 'Open in WhatsApp';

  @override
  String dcRecentsHeader(int count) {
    return 'RECENT · $count';
  }

  @override
  String get dcRecentsHint => 'Tap to reuse · long press to delete';

  @override
  String get dcEnterPhone => 'Enter a phone number';

  @override
  String get dcWaNotInstalled => 'WhatsApp not installed on device';

  @override
  String dcRemovedSnack(String number) {
    return '$number removed';
  }

  @override
  String get dcClearAllTitle => 'Clear history';

  @override
  String dcClearAllContent(int count) {
    return 'Do you really want to clear all $count recent numbers?';
  }

  @override
  String get dcClearAllTooltip => 'Clear all';

  @override
  String get textTitle => 'Text Tools';

  @override
  String get textClearTooltip => 'Clear text';

  @override
  String get textWriteHint => 'Write your text...';

  @override
  String textStylesAvailable(int count) {
    return '$count styles available';
  }

  @override
  String get textTapCopy => 'Tap COPY to copy';

  @override
  String get textCopied => 'COPIED';

  @override
  String get wishesTitle => 'Wishes & Status';

  @override
  String get wishCatTrending => '🔥 Trending';

  @override
  String get wishCatBirthday => '🎂 Birthday';

  @override
  String get wishCatEid => '🌙 Eid';

  @override
  String get wishCatDiwali => '🪔 Diwali';

  @override
  String get wishCatLove => '❤️ Love';

  @override
  String get wishCatShadi => '💍 Shadi';

  @override
  String get wishCatMotivation => '💪 Motivation';

  @override
  String get detailTitle => 'Customize';

  @override
  String get detailTextLabel => 'TEXT';

  @override
  String get detailTextHint => 'Edit message...';

  @override
  String get detailSizeLabel => 'SIZE';

  @override
  String get detailColorLabel => 'COLOR';

  @override
  String get detailShareText => 'Text';

  @override
  String get detailShareImage => 'Share image';

  @override
  String get detailCopyTooltip => 'Copy text';

  @override
  String get detailCopiedSnack => 'Copied!';

  @override
  String get fcEditorTitle => 'Fake Chat Editor';

  @override
  String get fcResetTooltip => 'Reset';

  @override
  String get fcExportTooltip => 'Export';

  @override
  String get fcReceived => 'Received';

  @override
  String get fcSent => 'Sent';

  @override
  String get fcResetTitle => 'New chat';

  @override
  String get fcResetContent =>
      'Do you want to clear all messages and start over?';

  @override
  String get fcEmptyHelp => 'Tap \"Received\" or \"Sent\" to add messages 👇';

  @override
  String get fcInputHint => 'Message';

  @override
  String get fcContact => 'Contact';

  @override
  String get fcNewMessage => 'New message';

  @override
  String get fcEditMessage => 'Edit message';

  @override
  String get fcText => 'TEXT';

  @override
  String get fcTextHint => 'Write the message...';

  @override
  String get fcTime => 'TIME';

  @override
  String get fcTicks => 'TICKS';

  @override
  String get fcTickSent => 'Sent';

  @override
  String get fcTickDelivered => 'Delivered';

  @override
  String get fcTickRead => 'Read';

  @override
  String get fcSave => 'Save';

  @override
  String get fcAdd => 'Add';

  @override
  String get fcDelete => 'Delete';

  @override
  String get fcEditContact => 'Edit contact';

  @override
  String get fcContactName => 'CONTACT NAME';

  @override
  String get fcContactNameHint => 'e.g. Sarah, Mom, Boss';

  @override
  String get fcStatus => 'STATUS';

  @override
  String get fcStatusHint => 'online, last seen today at 10:23';

  @override
  String get fcStatusOnline => 'online';

  @override
  String get fcStatusToday => 'last seen today at 10:23';

  @override
  String get fcStatusYesterday => 'last seen yesterday at 23:45';

  @override
  String get fcStatusJustNow => 'last seen just now';

  @override
  String get fcShowTyping => 'Show \"typing...\"';

  @override
  String get fcAvatarColor => 'AVATAR (COLOR)';

  @override
  String get fcTyping => 'typing...';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'v1.0.0 · 5 tools for WhatsApp';

  @override
  String get settingsPremium => 'PREMIUM';

  @override
  String get settingsPassToPremium => 'Go Premium';

  @override
  String get settingsPremiumDesc => 'Remove ads + exclusive sticker packs';

  @override
  String get settingsGeneral => 'GENERAL';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc => 'Birthday status reminders';

  @override
  String get settingsShare => 'SHARE';

  @override
  String get settingsShareApp => 'Recommend to a friend';

  @override
  String get settingsShareAppDesc => 'Share WhatsKit';

  @override
  String get settingsRate => 'Leave a review';

  @override
  String get settingsRateDesc => 'Support us on Play Store';

  @override
  String get settingsInfo => 'INFO';

  @override
  String get settingsPrivacy => 'Privacy Policy';

  @override
  String get settingsTerms => 'Terms of service';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutDesc => 'WhatsKit v1.0.0';

  @override
  String get settingsMadeWith => 'Made with 💚 by alutori';

  @override
  String get settingsDisclaimer =>
      'WhatsKit is not affiliated with WhatsApp Inc. or Meta';

  @override
  String get settingsLanguageDialogTitle => 'Choose language';

  @override
  String get settingsThemeDarkSoon => 'Dark mode coming soon!';

  @override
  String get settingsNotificationsSoon => 'Notifications coming soon!';

  @override
  String get settingsPremiumSoon => 'Premium coming soon!';

  @override
  String get settingsRateSoon => 'Available after store publication';

  @override
  String get settingsComingSoon => 'Coming soon';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get commonShare => 'Share';

  @override
  String get commonClose => 'Close';

  @override
  String get commonOk => 'OK';
}
