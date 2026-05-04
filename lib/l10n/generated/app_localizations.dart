import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('hi'),
    Locale('it'),
    Locale('ur'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'WhatsKit'**
  String get appName;

  /// No description provided for @searchTools.
  ///
  /// In en, this message translates to:
  /// **'Search tools...'**
  String get searchTools;

  /// No description provided for @toolsHeader.
  ///
  /// In en, this message translates to:
  /// **'WHATSAPP TOOLS'**
  String get toolsHeader;

  /// No description provided for @premiumBadge.
  ///
  /// In en, this message translates to:
  /// **'💎 Premium'**
  String get premiumBadge;

  /// No description provided for @premiumDesc.
  ///
  /// In en, this message translates to:
  /// **' · Remove ads + exclusive sticker packs · €2.99'**
  String get premiumDesc;

  /// No description provided for @tabTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tabTools;

  /// No description provided for @tabStickers.
  ///
  /// In en, this message translates to:
  /// **'Stickers'**
  String get tabStickers;

  /// No description provided for @tabWishes.
  ///
  /// In en, this message translates to:
  /// **'Wishes'**
  String get tabWishes;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @toolStickerMaker.
  ///
  /// In en, this message translates to:
  /// **'Sticker Maker'**
  String get toolStickerMaker;

  /// No description provided for @toolStickerMakerDesc.
  ///
  /// In en, this message translates to:
  /// **'Create stickers from photos · Remove background'**
  String get toolStickerMakerDesc;

  /// No description provided for @toolStickerMakerBadge.
  ///
  /// In en, this message translates to:
  /// **'AI ✨'**
  String get toolStickerMakerBadge;

  /// No description provided for @toolDirectChat.
  ///
  /// In en, this message translates to:
  /// **'Direct Chat'**
  String get toolDirectChat;

  /// No description provided for @toolDirectChatDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat without saving the number'**
  String get toolDirectChatDesc;

  /// No description provided for @toolDirectChatBadge.
  ///
  /// In en, this message translates to:
  /// **'⚡'**
  String get toolDirectChatBadge;

  /// No description provided for @toolTextFormatter.
  ///
  /// In en, this message translates to:
  /// **'Text Formatter'**
  String get toolTextFormatter;

  /// No description provided for @toolTextFormatterDesc.
  ///
  /// In en, this message translates to:
  /// **'𝓕𝓪𝓷𝓬𝔂 𝓕𝓸𝓷𝓽𝓼 · Bold · Italic'**
  String get toolTextFormatterDesc;

  /// No description provided for @toolTextFormatterBadge.
  ///
  /// In en, this message translates to:
  /// **'100+'**
  String get toolTextFormatterBadge;

  /// No description provided for @toolWishesMaker.
  ///
  /// In en, this message translates to:
  /// **'Wishes & Status'**
  String get toolWishesMaker;

  /// No description provided for @toolWishesMakerDesc.
  ///
  /// In en, this message translates to:
  /// **'Eid · Diwali · Birthday · Love'**
  String get toolWishesMakerDesc;

  /// No description provided for @toolWishesMakerBadge.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get toolWishesMakerBadge;

  /// No description provided for @toolFakeChat.
  ///
  /// In en, this message translates to:
  /// **'Fake Chat Generator'**
  String get toolFakeChat;

  /// No description provided for @toolFakeChatDesc.
  ///
  /// In en, this message translates to:
  /// **'Create fake chats for jokes'**
  String get toolFakeChatDesc;

  /// No description provided for @toolFakeChatBadge.
  ///
  /// In en, this message translates to:
  /// **'😆'**
  String get toolFakeChatBadge;

  /// No description provided for @stickerHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Background Remove'**
  String get stickerHeroTitle;

  /// No description provided for @stickerHeroDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload a photo · AI removes the background automatically · Create stickers ready for WhatsApp'**
  String get stickerHeroDesc;

  /// No description provided for @stickerStartNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get stickerStartNow;

  /// No description provided for @stickerMine.
  ///
  /// In en, this message translates to:
  /// **'MY STICKERS'**
  String get stickerMine;

  /// No description provided for @stickerEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No stickers yet'**
  String get stickerEmptyTitle;

  /// No description provided for @stickerEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Start now\" to create your first AI sticker'**
  String get stickerEmptyDesc;

  /// No description provided for @stickerSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose source'**
  String get stickerSourceTitle;

  /// No description provided for @stickerSourceCamera.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get stickerSourceCamera;

  /// No description provided for @stickerSourceCameraDesc.
  ///
  /// In en, this message translates to:
  /// **'Use the camera'**
  String get stickerSourceCameraDesc;

  /// No description provided for @stickerSourceGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get stickerSourceGallery;

  /// No description provided for @stickerSourceGalleryDesc.
  ///
  /// In en, this message translates to:
  /// **'Pick an existing photo'**
  String get stickerSourceGalleryDesc;

  /// No description provided for @stickerDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete sticker'**
  String get stickerDeleteTitle;

  /// No description provided for @stickerDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this sticker?'**
  String get stickerDeleteContent;

  /// No description provided for @editorNewSticker.
  ///
  /// In en, this message translates to:
  /// **'New Sticker'**
  String get editorNewSticker;

  /// No description provided for @editorResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get editorResult;

  /// No description provided for @editorSticker.
  ///
  /// In en, this message translates to:
  /// **'Sticker'**
  String get editorSticker;

  /// No description provided for @editorRemoveBgAi.
  ///
  /// In en, this message translates to:
  /// **'Remove background AI'**
  String get editorRemoveBgAi;

  /// No description provided for @editorSaveSticker.
  ///
  /// In en, this message translates to:
  /// **'Save sticker'**
  String get editorSaveSticker;

  /// No description provided for @editorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get editorRetry;

  /// No description provided for @editorShareToWA.
  ///
  /// In en, this message translates to:
  /// **'Share to WhatsApp'**
  String get editorShareToWA;

  /// No description provided for @editorProcessingTitle.
  ///
  /// In en, this message translates to:
  /// **'✨ AI at work...'**
  String get editorProcessingTitle;

  /// No description provided for @editorProcessingDesc.
  ///
  /// In en, this message translates to:
  /// **'Removing background from your photo.\nMay take 5-15 seconds.'**
  String get editorProcessingDesc;

  /// No description provided for @editorErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get editorErrorTitle;

  /// No description provided for @editorTipText.
  ///
  /// In en, this message translates to:
  /// **'For best results use photos with a clear, well-lit subject.'**
  String get editorTipText;

  /// No description provided for @editorSavedSnack.
  ///
  /// In en, this message translates to:
  /// **'Sticker saved!'**
  String get editorSavedSnack;

  /// No description provided for @editorSavedBadge.
  ///
  /// In en, this message translates to:
  /// **'SAVED'**
  String get editorSavedBadge;

  /// No description provided for @dcTitle.
  ///
  /// In en, this message translates to:
  /// **'Direct Chat'**
  String get dcTitle;

  /// No description provided for @dcInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'⚡ No contacts needed'**
  String get dcInfoTitle;

  /// No description provided for @dcInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat on WhatsApp with any number without adding it to your contacts.'**
  String get dcInfoDesc;

  /// No description provided for @dcPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'PHONE NUMBER'**
  String get dcPhoneLabel;

  /// No description provided for @dcPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'98765 43210'**
  String get dcPhoneHint;

  /// No description provided for @dcMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'MESSAGE (OPTIONAL)'**
  String get dcMessageLabel;

  /// No description provided for @dcMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Hi! I wanted to ask...'**
  String get dcMessageHint;

  /// No description provided for @dcOpenInWA.
  ///
  /// In en, this message translates to:
  /// **'Open in WhatsApp'**
  String get dcOpenInWA;

  /// No description provided for @dcRecentsHeader.
  ///
  /// In en, this message translates to:
  /// **'RECENT · {count}'**
  String dcRecentsHeader(int count);

  /// No description provided for @dcRecentsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to reuse · long press to delete'**
  String get dcRecentsHint;

  /// No description provided for @dcEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get dcEnterPhone;

  /// No description provided for @dcWaNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp not installed on device'**
  String get dcWaNotInstalled;

  /// No description provided for @dcRemovedSnack.
  ///
  /// In en, this message translates to:
  /// **'{number} removed'**
  String dcRemovedSnack(String number);

  /// No description provided for @dcClearAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get dcClearAllTitle;

  /// No description provided for @dcClearAllContent.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to clear all {count} recent numbers?'**
  String dcClearAllContent(int count);

  /// No description provided for @dcClearAllTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get dcClearAllTooltip;

  /// No description provided for @textTitle.
  ///
  /// In en, this message translates to:
  /// **'Text Tools'**
  String get textTitle;

  /// No description provided for @textClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear text'**
  String get textClearTooltip;

  /// No description provided for @textWriteHint.
  ///
  /// In en, this message translates to:
  /// **'Write your text...'**
  String get textWriteHint;

  /// No description provided for @textStylesAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} styles available'**
  String textStylesAvailable(int count);

  /// No description provided for @textTapCopy.
  ///
  /// In en, this message translates to:
  /// **'Tap COPY to copy'**
  String get textTapCopy;

  /// No description provided for @textCopied.
  ///
  /// In en, this message translates to:
  /// **'COPIED'**
  String get textCopied;

  /// No description provided for @wishesTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishes & Status'**
  String get wishesTitle;

  /// No description provided for @wishCatTrending.
  ///
  /// In en, this message translates to:
  /// **'🔥 Trending'**
  String get wishCatTrending;

  /// No description provided for @wishCatBirthday.
  ///
  /// In en, this message translates to:
  /// **'🎂 Birthday'**
  String get wishCatBirthday;

  /// No description provided for @wishCatEid.
  ///
  /// In en, this message translates to:
  /// **'🌙 Eid'**
  String get wishCatEid;

  /// No description provided for @wishCatDiwali.
  ///
  /// In en, this message translates to:
  /// **'🪔 Diwali'**
  String get wishCatDiwali;

  /// No description provided for @wishCatLove.
  ///
  /// In en, this message translates to:
  /// **'❤️ Love'**
  String get wishCatLove;

  /// No description provided for @wishCatShadi.
  ///
  /// In en, this message translates to:
  /// **'💍 Shadi'**
  String get wishCatShadi;

  /// No description provided for @wishCatMotivation.
  ///
  /// In en, this message translates to:
  /// **'💪 Motivation'**
  String get wishCatMotivation;

  /// No description provided for @detailTitle.
  ///
  /// In en, this message translates to:
  /// **'Customize'**
  String get detailTitle;

  /// No description provided for @detailTextLabel.
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get detailTextLabel;

  /// No description provided for @detailTextHint.
  ///
  /// In en, this message translates to:
  /// **'Edit message...'**
  String get detailTextHint;

  /// No description provided for @detailSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'SIZE'**
  String get detailSizeLabel;

  /// No description provided for @detailColorLabel.
  ///
  /// In en, this message translates to:
  /// **'COLOR'**
  String get detailColorLabel;

  /// No description provided for @detailShareText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get detailShareText;

  /// No description provided for @detailShareImage.
  ///
  /// In en, this message translates to:
  /// **'Share image'**
  String get detailShareImage;

  /// No description provided for @detailCopyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get detailCopyTooltip;

  /// No description provided for @detailCopiedSnack.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get detailCopiedSnack;

  /// No description provided for @fcEditorTitle.
  ///
  /// In en, this message translates to:
  /// **'Fake Chat Editor'**
  String get fcEditorTitle;

  /// No description provided for @fcResetTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get fcResetTooltip;

  /// No description provided for @fcExportTooltip.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get fcExportTooltip;

  /// No description provided for @fcReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get fcReceived;

  /// No description provided for @fcSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get fcSent;

  /// No description provided for @fcResetTitle.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get fcResetTitle;

  /// No description provided for @fcResetContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to clear all messages and start over?'**
  String get fcResetContent;

  /// No description provided for @fcEmptyHelp.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Received\" or \"Sent\" to add messages 👇'**
  String get fcEmptyHelp;

  /// No description provided for @fcInputHint.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get fcInputHint;

  /// No description provided for @fcContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get fcContact;

  /// No description provided for @fcNewMessage.
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get fcNewMessage;

  /// No description provided for @fcEditMessage.
  ///
  /// In en, this message translates to:
  /// **'Edit message'**
  String get fcEditMessage;

  /// No description provided for @fcText.
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get fcText;

  /// No description provided for @fcTextHint.
  ///
  /// In en, this message translates to:
  /// **'Write the message...'**
  String get fcTextHint;

  /// No description provided for @fcTime.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get fcTime;

  /// No description provided for @fcTicks.
  ///
  /// In en, this message translates to:
  /// **'TICKS'**
  String get fcTicks;

  /// No description provided for @fcTickSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get fcTickSent;

  /// No description provided for @fcTickDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get fcTickDelivered;

  /// No description provided for @fcTickRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get fcTickRead;

  /// No description provided for @fcSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get fcSave;

  /// No description provided for @fcAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get fcAdd;

  /// No description provided for @fcDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get fcDelete;

  /// No description provided for @fcEditContact.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get fcEditContact;

  /// No description provided for @fcContactName.
  ///
  /// In en, this message translates to:
  /// **'CONTACT NAME'**
  String get fcContactName;

  /// No description provided for @fcContactNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sarah, Mom, Boss'**
  String get fcContactNameHint;

  /// No description provided for @fcStatus.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get fcStatus;

  /// No description provided for @fcStatusHint.
  ///
  /// In en, this message translates to:
  /// **'online, last seen today at 10:23'**
  String get fcStatusHint;

  /// No description provided for @fcStatusOnline.
  ///
  /// In en, this message translates to:
  /// **'online'**
  String get fcStatusOnline;

  /// No description provided for @fcStatusToday.
  ///
  /// In en, this message translates to:
  /// **'last seen today at 10:23'**
  String get fcStatusToday;

  /// No description provided for @fcStatusYesterday.
  ///
  /// In en, this message translates to:
  /// **'last seen yesterday at 23:45'**
  String get fcStatusYesterday;

  /// No description provided for @fcStatusJustNow.
  ///
  /// In en, this message translates to:
  /// **'last seen just now'**
  String get fcStatusJustNow;

  /// No description provided for @fcShowTyping.
  ///
  /// In en, this message translates to:
  /// **'Show \"typing...\"'**
  String get fcShowTyping;

  /// No description provided for @fcAvatarColor.
  ///
  /// In en, this message translates to:
  /// **'AVATAR (COLOR)'**
  String get fcAvatarColor;

  /// No description provided for @fcTyping.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get fcTyping;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0 · 5 tools for WhatsApp'**
  String get settingsSubtitle;

  /// No description provided for @settingsPremium.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get settingsPremium;

  /// No description provided for @settingsPassToPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get settingsPassToPremium;

  /// No description provided for @settingsPremiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove ads + exclusive sticker packs'**
  String get settingsPremiumDesc;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get settingsGeneral;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Birthday status reminders'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsShare.
  ///
  /// In en, this message translates to:
  /// **'SHARE'**
  String get settingsShare;

  /// No description provided for @settingsShareApp.
  ///
  /// In en, this message translates to:
  /// **'Recommend to a friend'**
  String get settingsShareApp;

  /// No description provided for @settingsShareAppDesc.
  ///
  /// In en, this message translates to:
  /// **'Share WhatsKit'**
  String get settingsShareAppDesc;

  /// No description provided for @settingsRate.
  ///
  /// In en, this message translates to:
  /// **'Leave a review'**
  String get settingsRate;

  /// No description provided for @settingsRateDesc.
  ///
  /// In en, this message translates to:
  /// **'Support us on Play Store'**
  String get settingsRateDesc;

  /// No description provided for @settingsInfo.
  ///
  /// In en, this message translates to:
  /// **'INFO'**
  String get settingsInfo;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingsTerms;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutDesc.
  ///
  /// In en, this message translates to:
  /// **'WhatsKit v1.0.0'**
  String get settingsAboutDesc;

  /// No description provided for @settingsMadeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with 💚 by alutori'**
  String get settingsMadeWith;

  /// No description provided for @settingsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'WhatsKit is not affiliated with WhatsApp Inc. or Meta'**
  String get settingsDisclaimer;

  /// No description provided for @settingsLanguageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settingsLanguageDialogTitle;

  /// No description provided for @settingsThemeDarkSoon.
  ///
  /// In en, this message translates to:
  /// **'Dark mode coming soon!'**
  String get settingsThemeDarkSoon;

  /// No description provided for @settingsNotificationsSoon.
  ///
  /// In en, this message translates to:
  /// **'Notifications coming soon!'**
  String get settingsNotificationsSoon;

  /// No description provided for @settingsPremiumSoon.
  ///
  /// In en, this message translates to:
  /// **'Premium coming soon!'**
  String get settingsPremiumSoon;

  /// No description provided for @settingsRateSoon.
  ///
  /// In en, this message translates to:
  /// **'Available after store publication'**
  String get settingsRateSoon;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get settingsComingSoon;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'hi', 'it', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
