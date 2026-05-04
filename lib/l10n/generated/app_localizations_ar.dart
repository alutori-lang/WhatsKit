// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'WhatsKit';

  @override
  String get searchTools => 'البحث عن الأدوات...';

  @override
  String get toolsHeader => 'أدوات واتساب';

  @override
  String get premiumBadge => '💎 بريميوم';

  @override
  String get premiumDesc => ' · إزالة الإعلانات + حزم ملصقات حصرية · €2.99';

  @override
  String get tabTools => 'الأدوات';

  @override
  String get tabStickers => 'الملصقات';

  @override
  String get tabWishes => 'التهاني';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get toolStickerMaker => 'صانع الملصقات';

  @override
  String get toolStickerMakerDesc => 'أنشئ ملصقات من الصور · إزالة الخلفية';

  @override
  String get toolStickerMakerBadge => 'AI ✨';

  @override
  String get toolDirectChat => 'دردشة مباشرة';

  @override
  String get toolDirectChatDesc => 'الدردشة بدون حفظ الرقم';

  @override
  String get toolDirectChatBadge => '⚡';

  @override
  String get toolTextFormatter => 'منسق النصوص';

  @override
  String get toolTextFormatterDesc => '𝓕𝓪𝓷𝓬𝔂 خطوط · غامق · مائل';

  @override
  String get toolTextFormatterBadge => '100+';

  @override
  String get toolWishesMaker => 'تهاني وحالات';

  @override
  String get toolWishesMakerDesc => 'عيد · ديوالي · عيد ميلاد · حب';

  @override
  String get toolWishesMakerBadge => 'جديد';

  @override
  String get toolFakeChat => 'مولد الدردشات الوهمية';

  @override
  String get toolFakeChatDesc => 'أنشئ دردشات وهمية للمزاح';

  @override
  String get toolFakeChatBadge => '😆';

  @override
  String get stickerHeroTitle => 'إزالة الخلفية بالذكاء الاصطناعي';

  @override
  String get stickerHeroDesc =>
      'حمّل صورة · يقوم الذكاء الاصطناعي بإزالة الخلفية تلقائيًا · أنشئ ملصقات جاهزة لواتساب';

  @override
  String get stickerStartNow => 'ابدأ الآن';

  @override
  String get stickerMine => 'ملصقاتي';

  @override
  String get stickerEmptyTitle => 'لا توجد ملصقات بعد';

  @override
  String get stickerEmptyDesc => 'اضغط على \"ابدأ الآن\" لإنشاء أول ملصق AI';

  @override
  String get stickerSourceTitle => 'اختر المصدر';

  @override
  String get stickerSourceCamera => 'التقط صورة';

  @override
  String get stickerSourceCameraDesc => 'استخدم الكاميرا';

  @override
  String get stickerSourceGallery => 'المعرض';

  @override
  String get stickerSourceGalleryDesc => 'اختر صورة موجودة';

  @override
  String get stickerDeleteTitle => 'حذف الملصق';

  @override
  String get stickerDeleteContent => 'هل تريد حقًا حذف هذا الملصق؟';

  @override
  String get editorNewSticker => 'ملصق جديد';

  @override
  String get editorResult => 'النتيجة';

  @override
  String get editorSticker => 'ملصق';

  @override
  String get editorRemoveBgAi => 'إزالة الخلفية بالذكاء الاصطناعي';

  @override
  String get editorSaveSticker => 'احفظ الملصق';

  @override
  String get editorRetry => 'أعد المحاولة';

  @override
  String get editorShareToWA => 'شارك على واتساب';

  @override
  String get editorProcessingTitle => '✨ الذكاء الاصطناعي يعمل...';

  @override
  String get editorProcessingDesc =>
      'جاري إزالة الخلفية من صورتك.\nقد يستغرق 5-15 ثانية.';

  @override
  String get editorErrorTitle => 'عذرًا! حدث خطأ ما';

  @override
  String get editorTipText =>
      'للحصول على أفضل النتائج استخدم صورًا بموضوع واضح ومضاء جيدًا.';

  @override
  String get editorSavedSnack => 'تم حفظ الملصق!';

  @override
  String get editorSavedBadge => 'محفوظ';

  @override
  String get dcTitle => 'دردشة مباشرة';

  @override
  String get dcInfoTitle => '⚡ بدون حفظ جهات الاتصال';

  @override
  String get dcInfoDesc =>
      'تواصل عبر واتساب مع أي رقم دون إضافته إلى جهات الاتصال.';

  @override
  String get dcPhoneLabel => 'رقم الهاتف';

  @override
  String get dcPhoneHint => '98765 43210';

  @override
  String get dcMessageLabel => 'الرسالة (اختياري)';

  @override
  String get dcMessageHint => 'مرحبًا! أردت أن أسأل...';

  @override
  String get dcOpenInWA => 'افتح في واتساب';

  @override
  String dcRecentsHeader(int count) {
    return 'الحديثة · $count';
  }

  @override
  String get dcRecentsHint => 'اضغط لإعادة الاستخدام · اضغط مطولاً للحذف';

  @override
  String get dcEnterPhone => 'أدخل رقم هاتف';

  @override
  String get dcWaNotInstalled => 'واتساب غير مثبت على الجهاز';

  @override
  String dcRemovedSnack(String number) {
    return 'تمت إزالة $number';
  }

  @override
  String get dcClearAllTitle => 'مسح السجل';

  @override
  String dcClearAllContent(int count) {
    return 'هل تريد حقًا مسح جميع الأرقام الحديثة الـ $count؟';
  }

  @override
  String get dcClearAllTooltip => 'مسح الكل';

  @override
  String get textTitle => 'أدوات النص';

  @override
  String get textClearTooltip => 'مسح النص';

  @override
  String get textWriteHint => 'اكتب نصك...';

  @override
  String textStylesAvailable(int count) {
    return '$count نمطًا متاحًا';
  }

  @override
  String get textTapCopy => 'اضغط COPY للنسخ';

  @override
  String get textCopied => 'تم النسخ';

  @override
  String get wishesTitle => 'التهاني والحالات';

  @override
  String get wishCatTrending => '🔥 الرائج';

  @override
  String get wishCatBirthday => '🎂 عيد ميلاد';

  @override
  String get wishCatEid => '🌙 عيد';

  @override
  String get wishCatDiwali => '🪔 ديوالي';

  @override
  String get wishCatLove => '❤️ حب';

  @override
  String get wishCatShadi => '💍 زواج';

  @override
  String get wishCatMotivation => '💪 تحفيز';

  @override
  String get detailTitle => 'تخصيص';

  @override
  String get detailTextLabel => 'النص';

  @override
  String get detailTextHint => 'تعديل الرسالة...';

  @override
  String get detailSizeLabel => 'الحجم';

  @override
  String get detailColorLabel => 'اللون';

  @override
  String get detailShareText => 'نص';

  @override
  String get detailShareImage => 'شارك الصورة';

  @override
  String get detailCopyTooltip => 'انسخ النص';

  @override
  String get detailCopiedSnack => 'تم النسخ!';

  @override
  String get fcEditorTitle => 'محرر الدردشة الوهمية';

  @override
  String get fcResetTooltip => 'إعادة تعيين';

  @override
  String get fcExportTooltip => 'تصدير';

  @override
  String get fcReceived => 'مستلم';

  @override
  String get fcSent => 'مرسل';

  @override
  String get fcResetTitle => 'دردشة جديدة';

  @override
  String get fcResetContent => 'هل تريد مسح جميع الرسائل والبدء من جديد؟';

  @override
  String get fcEmptyHelp => 'اضغط \"مستلم\" أو \"مرسل\" لإضافة رسائل 👇';

  @override
  String get fcInputHint => 'رسالة';

  @override
  String get fcContact => 'جهة اتصال';

  @override
  String get fcNewMessage => 'رسالة جديدة';

  @override
  String get fcEditMessage => 'تعديل الرسالة';

  @override
  String get fcText => 'النص';

  @override
  String get fcTextHint => 'اكتب الرسالة...';

  @override
  String get fcTime => 'الوقت';

  @override
  String get fcTicks => 'العلامات';

  @override
  String get fcTickSent => 'مرسل';

  @override
  String get fcTickDelivered => 'تم التسليم';

  @override
  String get fcTickRead => 'تمت القراءة';

  @override
  String get fcSave => 'حفظ';

  @override
  String get fcAdd => 'إضافة';

  @override
  String get fcDelete => 'حذف';

  @override
  String get fcEditContact => 'تعديل جهة الاتصال';

  @override
  String get fcContactName => 'اسم جهة الاتصال';

  @override
  String get fcContactNameHint => 'مثال: سارة، أمي، المدير';

  @override
  String get fcStatus => 'الحالة';

  @override
  String get fcStatusHint => 'online, last seen today at 10:23';

  @override
  String get fcStatusOnline => 'متصل';

  @override
  String get fcStatusToday => 'آخر ظهور اليوم في 10:23';

  @override
  String get fcStatusYesterday => 'آخر ظهور أمس في 23:45';

  @override
  String get fcStatusJustNow => 'آخر ظهور قبل قليل';

  @override
  String get fcShowTyping => 'أظهر \"يكتب...\"';

  @override
  String get fcAvatarColor => 'الأفاتار (اللون)';

  @override
  String get fcTyping => 'يكتب...';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSubtitle => 'v1.0.0 · 5 أدوات لواتساب';

  @override
  String get settingsPremium => 'بريميوم';

  @override
  String get settingsPassToPremium => 'اشترك في بريميوم';

  @override
  String get settingsPremiumDesc => 'إزالة الإعلانات + حزم ملصقات حصرية';

  @override
  String get settingsGeneral => 'عام';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTheme => 'السمة';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsNotificationsDesc => 'تذكيرات حالات أعياد الميلاد';

  @override
  String get settingsShare => 'مشاركة';

  @override
  String get settingsShareApp => 'أوصِ صديقًا';

  @override
  String get settingsShareAppDesc => 'شارك WhatsKit';

  @override
  String get settingsRate => 'اترك تقييمًا';

  @override
  String get settingsRateDesc => 'ادعمنا على Play Store';

  @override
  String get settingsInfo => 'معلومات';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsTerms => 'شروط الخدمة';

  @override
  String get settingsAbout => 'حول';

  @override
  String get settingsAboutDesc => 'WhatsKit v1.0.0';

  @override
  String get settingsMadeWith => 'صُنع بحب 💚 من قبل alutori';

  @override
  String get settingsDisclaimer =>
      'WhatsKit ليس تابعًا لـ WhatsApp Inc. أو Meta';

  @override
  String get settingsLanguageDialogTitle => 'اختر اللغة';

  @override
  String get settingsThemeDarkSoon => 'الوضع الداكن قادم قريبًا!';

  @override
  String get settingsNotificationsSoon => 'الإشعارات قادمة قريبًا!';

  @override
  String get settingsPremiumSoon => 'بريميوم قادم قريبًا!';

  @override
  String get settingsRateSoon => 'متاح بعد النشر في المتجر';

  @override
  String get settingsComingSoon => 'قريبًا';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonRetry => 'أعد المحاولة';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonShare => 'مشاركة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonOk => 'موافق';
}
