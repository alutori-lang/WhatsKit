// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'WhatsKit';

  @override
  String get searchTools => 'Cerca strumenti...';

  @override
  String get toolsHeader => 'STRUMENTI WHATSAPP';

  @override
  String get premiumBadge => '💎 Premium';

  @override
  String get premiumDesc =>
      ' · Rimuovi pubblicità + sticker pack esclusivi · €2.99';

  @override
  String get tabTools => 'Strumenti';

  @override
  String get tabStickers => 'Sticker';

  @override
  String get tabWishes => 'Auguri';

  @override
  String get tabSettings => 'Impostazioni';

  @override
  String get toolStickerMaker => 'Sticker Maker';

  @override
  String get toolStickerMakerDesc => 'Crea sticker da foto · Rimuovi sfondo';

  @override
  String get toolStickerMakerBadge => 'AI ✨';

  @override
  String get toolDirectChat => 'Direct Chat';

  @override
  String get toolDirectChatDesc => 'Chatta senza salvare il numero';

  @override
  String get toolDirectChatBadge => '⚡';

  @override
  String get toolTextFormatter => 'Text Formatter';

  @override
  String get toolTextFormatterDesc => '𝓕𝓪𝓷𝓬𝔂 𝓕𝓸𝓷𝓽𝓼 · Bold · Italic';

  @override
  String get toolTextFormatterBadge => '100+';

  @override
  String get toolWishesMaker => 'Auguri & Status';

  @override
  String get toolWishesMakerDesc => 'Eid · Diwali · Compleanno · Amore';

  @override
  String get toolWishesMakerBadge => 'NUOVO';

  @override
  String get toolFakeChat => 'Generatore Chat Finta';

  @override
  String get toolFakeChatDesc => 'Crea chat finte per scherzi';

  @override
  String get toolFakeChatBadge => '😆';

  @override
  String get stickerHeroTitle => 'Rimuovi Sfondo AI';

  @override
  String get stickerHeroDesc =>
      'Carica una foto · L\'AI rimuove lo sfondo automaticamente · Crea sticker pronti per WhatsApp';

  @override
  String get stickerStartNow => 'Inizia ora';

  @override
  String get stickerMine => 'I MIEI STICKER';

  @override
  String get stickerEmptyTitle => 'Nessuno sticker ancora';

  @override
  String get stickerEmptyDesc =>
      'Tap su \"Inizia ora\" per creare il tuo primo sticker AI';

  @override
  String get stickerSourceTitle => 'Scegli sorgente';

  @override
  String get stickerSourceCamera => 'Scatta foto';

  @override
  String get stickerSourceCameraDesc => 'Usa la fotocamera';

  @override
  String get stickerSourceGallery => 'Galleria';

  @override
  String get stickerSourceGalleryDesc => 'Scegli una foto esistente';

  @override
  String get stickerDeleteTitle => 'Elimina sticker';

  @override
  String get stickerDeleteContent => 'Vuoi davvero eliminare questo sticker?';

  @override
  String get editorNewSticker => 'Nuovo Sticker';

  @override
  String get editorResult => 'Risultato';

  @override
  String get editorSticker => 'Sticker';

  @override
  String get editorRemoveBgAi => 'Rimuovi sfondo AI';

  @override
  String get editorSaveSticker => 'Salva sticker';

  @override
  String get editorRetry => 'Riprova';

  @override
  String get editorShareToWA => 'Condividi su WhatsApp';

  @override
  String get editorProcessingTitle => '✨ AI al lavoro...';

  @override
  String get editorProcessingDesc =>
      'Sto rimuovendo lo sfondo dalla tua foto.\nPuò richiedere 5-15 secondi.';

  @override
  String get editorErrorTitle => 'Ops! Qualcosa è andato storto';

  @override
  String get editorTipText =>
      'Per i risultati migliori usa foto con un soggetto chiaro e ben illuminato.';

  @override
  String get editorSavedSnack => 'Sticker salvato!';

  @override
  String get editorSavedBadge => 'SALVATO';

  @override
  String get dcTitle => 'Direct Chat';

  @override
  String get dcInfoTitle => '⚡ Senza salvare contatti';

  @override
  String get dcInfoDesc =>
      'Chatta su WhatsApp con qualsiasi numero senza aggiungerlo alla rubrica.';

  @override
  String get dcPhoneLabel => 'NUMERO DI TELEFONO';

  @override
  String get dcPhoneHint => '98765 43210';

  @override
  String get dcMessageLabel => 'MESSAGGIO (OPZIONALE)';

  @override
  String get dcMessageHint => 'Ciao! Volevo chiederti...';

  @override
  String get dcOpenInWA => 'Apri in WhatsApp';

  @override
  String dcRecentsHeader(int count) {
    return 'RECENTI · $count';
  }

  @override
  String get dcRecentsHint => 'Tap per riusare · tieni premuto per eliminare';

  @override
  String get dcEnterPhone => 'Inserisci un numero di telefono';

  @override
  String get dcWaNotInstalled => 'WhatsApp non installato sul dispositivo';

  @override
  String dcRemovedSnack(String number) {
    return '$number rimosso';
  }

  @override
  String get dcClearAllTitle => 'Cancella cronologia';

  @override
  String dcClearAllContent(int count) {
    return 'Vuoi davvero cancellare tutti i $count numeri recenti?';
  }

  @override
  String get dcClearAllTooltip => 'Cancella tutto';

  @override
  String get textTitle => 'Text Tools';

  @override
  String get textClearTooltip => 'Cancella testo';

  @override
  String get textWriteHint => 'Scrivi il tuo testo...';

  @override
  String textStylesAvailable(int count) {
    return '$count stili disponibili';
  }

  @override
  String get textTapCopy => 'Tap COPY per copiare';

  @override
  String get textCopied => 'COPIATO';

  @override
  String get wishesTitle => 'Auguri & Status';

  @override
  String get wishCatTrending => '🔥 Trending';

  @override
  String get wishCatBirthday => '🎂 Compleanno';

  @override
  String get wishCatEid => '🌙 Eid';

  @override
  String get wishCatDiwali => '🪔 Diwali';

  @override
  String get wishCatLove => '❤️ Amore';

  @override
  String get wishCatShadi => '💍 Matrimonio';

  @override
  String get wishCatMotivation => '💪 Motivazione';

  @override
  String get detailTitle => 'Personalizza';

  @override
  String get detailTextLabel => 'TESTO';

  @override
  String get detailTextHint => 'Modifica il messaggio...';

  @override
  String get detailSizeLabel => 'GRANDEZZA';

  @override
  String get detailColorLabel => 'COLORE';

  @override
  String get detailShareText => 'Testo';

  @override
  String get detailShareImage => 'Condividi immagine';

  @override
  String get detailCopyTooltip => 'Copia testo';

  @override
  String get detailCopiedSnack => 'Copiato!';

  @override
  String get fcEditorTitle => 'Editor Fake Chat';

  @override
  String get fcResetTooltip => 'Reset';

  @override
  String get fcExportTooltip => 'Esporta';

  @override
  String get fcReceived => 'Ricevuto';

  @override
  String get fcSent => 'Inviato';

  @override
  String get fcResetTitle => 'Nuova chat';

  @override
  String get fcResetContent =>
      'Vuoi cancellare tutti i messaggi e ricominciare?';

  @override
  String get fcEmptyHelp =>
      'Tap \"Ricevuto\" o \"Inviato\" per aggiungere messaggi 👇';

  @override
  String get fcInputHint => 'Messaggio';

  @override
  String get fcContact => 'Contatto';

  @override
  String get fcNewMessage => 'Nuovo messaggio';

  @override
  String get fcEditMessage => 'Modifica messaggio';

  @override
  String get fcText => 'TESTO';

  @override
  String get fcTextHint => 'Scrivi il messaggio...';

  @override
  String get fcTime => 'ORA';

  @override
  String get fcTicks => 'SPUNTE';

  @override
  String get fcTickSent => 'Inviato';

  @override
  String get fcTickDelivered => 'Consegnato';

  @override
  String get fcTickRead => 'Letto';

  @override
  String get fcSave => 'Salva';

  @override
  String get fcAdd => 'Aggiungi';

  @override
  String get fcDelete => 'Elimina';

  @override
  String get fcEditContact => 'Modifica contatto';

  @override
  String get fcContactName => 'NOME CONTATTO';

  @override
  String get fcContactNameHint => 'es: Sarah, Mamma, Boss';

  @override
  String get fcStatus => 'STATO';

  @override
  String get fcStatusHint => 'online, ultimo accesso oggi alle 10:23';

  @override
  String get fcStatusOnline => 'online';

  @override
  String get fcStatusToday => 'ultimo accesso oggi alle 10:23';

  @override
  String get fcStatusYesterday => 'ultimo accesso ieri alle 23:45';

  @override
  String get fcStatusJustNow => 'ultimo accesso poco fa';

  @override
  String get fcShowTyping => 'Mostra \"sta scrivendo...\"';

  @override
  String get fcAvatarColor => 'AVATAR (COLORE)';

  @override
  String get fcTyping => 'sta scrivendo...';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSubtitle => 'v1.0.0 · 5 strumenti per WhatsApp';

  @override
  String get settingsPremium => 'PREMIUM';

  @override
  String get settingsPassToPremium => 'Passa a Premium';

  @override
  String get settingsPremiumDesc =>
      'Rimuovi pubblicità + sticker pack esclusivi';

  @override
  String get settingsGeneral => 'GENERALE';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Chiaro';

  @override
  String get settingsNotifications => 'Notifiche';

  @override
  String get settingsNotificationsDesc => 'Promemoria status compleanni';

  @override
  String get settingsShare => 'CONDIVIDI';

  @override
  String get settingsShareApp => 'Consiglia ad un amico';

  @override
  String get settingsShareAppDesc => 'Condividi WhatsKit';

  @override
  String get settingsRate => 'Lascia una recensione';

  @override
  String get settingsRateDesc => 'Supportaci su Play Store';

  @override
  String get settingsInfo => 'INFO';

  @override
  String get settingsPrivacy => 'Privacy Policy';

  @override
  String get settingsTerms => 'Termini di servizio';

  @override
  String get settingsAbout => 'Informazioni';

  @override
  String get settingsAboutDesc => 'WhatsKit v1.0.0';

  @override
  String get settingsMadeWith => 'Made with 💚 by alutori';

  @override
  String get settingsDisclaimer =>
      'WhatsKit non è affiliato con WhatsApp Inc. o Meta';

  @override
  String get settingsLanguageDialogTitle => 'Scegli lingua';

  @override
  String get settingsThemeDarkSoon => 'Dark mode in arrivo!';

  @override
  String get settingsNotificationsSoon => 'Notifiche in arrivo!';

  @override
  String get settingsPremiumSoon => 'Premium in arrivo!';

  @override
  String get settingsRateSoon => 'Disponibile dopo pubblicazione store';

  @override
  String get settingsComingSoon => 'In arrivo';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonShare => 'Condividi';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonOk => 'OK';
}
