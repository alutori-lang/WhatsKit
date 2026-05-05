# 📱 Store Release Guide — WhatsKit

Guida completa per pubblicare WhatsKit su **Google Play Store** e **Apple App Store**.

---

## ✅ Stato attuale

- ✅ App icon applicata (logo #3 Sticker Smile)
- ✅ Android adaptive icon (Android 8.0+) configurato
- ✅ iOS app icons in tutte le risoluzioni
- ✅ iOS Info.plist con permission descriptions
- ✅ Android AndroidManifest con permissions
- ✅ Android build.gradle.kts pronto per release signing

---

## 🤖 ANDROID — Google Play Store

### Step 1: Genera il keystore di firma (UNA TANTUM)

⚠️ **Salva il keystore in luogo sicuro!** Se lo perdi non potrai più aggiornare l'app sul Play Store.

```bash
# Esegui dalla root del progetto
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

Ti chiederà:
- Password keystore (segnala!)
- Nome, organizzazione, città, paese
- Password chiave (può essere uguale al keystore)

Output: `upload-keystore.jks` (NON committare su git, è già nel .gitignore).

### Step 2: Crea `android/key.properties`

```properties
storePassword=LA_TUA_PASSWORD_KEYSTORE
keyPassword=LA_TUA_PASSWORD_CHIAVE
keyAlias=upload
storeFile=../../upload-keystore.jks
```

⚠️ Già gitignored. Salva fuori dal repo come backup.

### Step 3: Build release AAB (Android App Bundle)

Play Store richiede AAB, non APK:

```bash
flutter build appbundle --release \
  --dart-define=GEMINI_API_KEY=$(grep GEMINI_API_KEY android/gemini.properties | cut -d= -f2) \
  --dart-define=REMOVE_BG_API_KEY=$(grep REMOVE_BG_API_KEY android/gemini.properties | cut -d= -f2)
```

Output: `build/app/outputs/bundle/release/app-release.aab` (~30-50 MB)

### Step 4: Test APK release locale (opzionale)

```bash
flutter build apk --release \
  --dart-define=GEMINI_API_KEY=... \
  --dart-define=REMOVE_BG_API_KEY=...
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Step 5: Upload su Play Console

1. Vai su https://play.google.com/console
2. **Crea app** → "WhatsKit"
3. **Scheda store**:
   - Nome breve: WhatsKit
   - Descrizione breve: 5 strumenti per WhatsApp - sticker, chat diretta, font, status
   - Descrizione completa: vedi sotto
   - Icona: `branding/output/icon-512.png` (richiesto 512x512 PNG, 32-bit)
   - Feature graphic: 1024x500 (devi crearne uno - vedi assets/store/)
   - Screenshots: minimo 2 phone (1080x1920 max)
4. **Privacy policy**: URL obbligatorio (puoi usare GitHub Pages)
5. **Categorizzazione**: Communication / Social
6. **Rating**: compila questionnaire (no contenuti adulti)
7. **Pricing**: Free
8. **Release** → produzione → upload AAB
9. Review (1-3 giorni)

### Asset richiesti per il listing Play Store

- ✅ App icon: `branding/output/icon-512.png`
- ❌ Feature graphic 1024x500 (TODO)
- ❌ Screenshots phone (almeno 2): da fare
- ❌ Privacy policy: da scrivere (vedi sotto)

---

## 🍎 iOS — Apple App Store

### Prerequisiti

- ⚠️ **Mac fisico o Mac in cloud** (es. MacInCloud, MacStadium) - Xcode non gira su Windows
- Apple Developer Account ($99/anno)
- Xcode 15+

### Step 1: Apri progetto Xcode su Mac

```bash
cd ios
pod install
open Runner.xcworkspace
```

### Step 2: Configura signing in Xcode

1. Seleziona target **Runner**
2. Tab **Signing & Capabilities**
3. Team: scegli il tuo Apple Developer team
4. Bundle Identifier: `com.whatskit.whatskit` (cambia se occupato)
5. Automatic signing: ON

### Step 3: Configura Bundle Identifier

In `ios/Runner.xcodeproj/project.pbxproj` cerca `PRODUCT_BUNDLE_IDENTIFIER` e cambia da `com.example.whatskit` (default Flutter) a:

```
PRODUCT_BUNDLE_IDENTIFIER = com.whatskit.whatskit;
```

(Già configurato. Verifica.)

### Step 4: Build per simulatore (test)

```bash
flutter build ios --release \
  --dart-define=GEMINI_API_KEY=... \
  --dart-define=REMOVE_BG_API_KEY=...
```

### Step 5: Archivia e carica su App Store Connect

In Xcode:
1. **Product** → **Archive** (genera .ipa)
2. **Window** → **Organizer**
3. Seleziona archivio → **Distribute App** → **App Store Connect**
4. Upload

### Step 6: Configura su App Store Connect

1. https://appstoreconnect.apple.com
2. Crea nuova app:
   - Bundle ID: `com.whatskit.whatskit`
   - Nome: WhatsKit
   - Lingua: Italian
3. Compila tutto:
   - Descrizione (4000 caratteri max)
   - Keywords
   - Screenshots (6.5" iPhone + 12.9" iPad)
   - Icona App Store: `branding/output/ios-Icon-1024.png`
4. **Submit for Review** (1-3 giorni)

---

## 📝 Privacy Policy (TEMPLATE)

Crea un GitHub repo `whatskit-privacy` con `index.html`:

```html
<!DOCTYPE html>
<html>
<head><title>WhatsKit Privacy Policy</title></head>
<body>
<h1>Privacy Policy — WhatsKit</h1>
<p>Last updated: 2026-05-05</p>

<h2>What we collect</h2>
<p>WhatsKit doesn't collect any personal data. All processing happens on your device.</p>

<h2>Photos & Stickers</h2>
<p>Photos selected for sticker creation are sent to remove.bg API for background
removal. They are NOT stored on our servers. After processing, the result is
saved only on your device.</p>

<h2>Permissions</h2>
<ul>
<li><b>Camera</b>: take photos for stickers</li>
<li><b>Photo library</b>: select existing photos</li>
<li><b>Internet</b>: send photos to remove.bg AI for processing</li>
</ul>

<h2>Third-party services</h2>
<ul>
<li><b>remove.bg</b>: background removal AI (https://www.remove.bg/privacy)</li>
<li><b>Google ML Kit</b>: on-device fallback (no data sent)</li>
</ul>

<h2>Children</h2>
<p>WhatsKit does not knowingly collect data from children under 13.</p>

<h2>Contact</h2>
<p>For questions: alutori@gmail.com</p>
</body>
</html>
```

Pubblica via GitHub Pages → URL della Pages = privacy policy URL.

---

## 🎨 Screenshot da preparare

Per Play Store + App Store (consigliato 5-6 per ogni store):

1. **Home** — 5 strumenti in lista
2. **Sticker Maker** — risultato sticker su pattern checkered
3. **Direct Chat** — form numero + messaggio
4. **Text Tools** — lista 38 stili
5. **Wishes Maker** — griglia status colorati
6. **Fake Chat** — chat clone WhatsApp con bubbles

**Tool consigliato**: usa l'emulatore Android Studio o iPhone Simulator + screenshot, poi aggiungi cornice device con https://shotbot.io o https://screenshot.rocks

---

## 🚀 Release checklist finale

### Prima di submitting:
- [ ] Test su dispositivo fisico Android
- [ ] Test su dispositivo fisico iOS (o simulatore)
- [ ] Verifica tutte le 5 feature funzionano
- [ ] Privacy Policy URL pubblica
- [ ] Screenshot fatti
- [ ] Feature graphic 1024x500 fatto (Android)
- [ ] App icon 512 (Android) e 1024 (iOS) pronti
- [ ] Description tradotta in IT/EN/HI/UR
- [ ] Versione: 1.0.0+1 in pubspec.yaml
- [ ] API keys valide (Gemini, remove.bg)

### Asset paths:
- Android icon Play Store: `branding/output/icon-512.png`
- iOS icon App Store: `branding/output/ios-Icon-1024.png`
- AAB: `build/app/outputs/bundle/release/app-release.aab` (build con Step 3)
- iOS .ipa: generato da Xcode Archive (Step 5)

---

## 💰 Monetizzazione (post-launch)

L'app è gratuita ma puoi aggiungere:
- **AdMob banner** in Home (gradle: `com.google.android.gms:play-services-ads`)
- **Premium €2.99** (in-app purchase): rimuove ads + sticker pack esclusivi
- **Subscription** remove.bg condivisa: ogni utente ha 5 sticker/mese gratis,
  Premium ne ha 50

---

🎉 **Buona pubblicazione!**
