// Convert SVG logo to PNG at multiple resolutions for Android + iOS launcher icons
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const SOURCE = process.argv[2] || 'logos/03-smile.svg';
const OUTPUT_DIR = process.argv[3] || 'output';

if (!fs.existsSync(OUTPUT_DIR)) fs.mkdirSync(OUTPUT_DIR, { recursive: true });

const sizes = [
  // Generic large sizes (Play Store, App Store)
  { name: 'icon-1024.png', size: 1024 },
  { name: 'icon-512.png', size: 512 },

  // ===== ANDROID =====
  // Standard launcher (square)
  { name: 'android-mdpi.png', size: 48 },
  { name: 'android-hdpi.png', size: 72 },
  { name: 'android-xhdpi.png', size: 96 },
  { name: 'android-xxhdpi.png', size: 144 },
  { name: 'android-xxxhdpi.png', size: 192 },
  // Adaptive icon foreground (108dp safe zone) - source 432x432
  { name: 'android-foreground-mdpi.png', size: 108 },
  { name: 'android-foreground-hdpi.png', size: 162 },
  { name: 'android-foreground-xhdpi.png', size: 216 },
  { name: 'android-foreground-xxhdpi.png', size: 324 },
  { name: 'android-foreground-xxxhdpi.png', size: 432 },

  // ===== iOS =====
  // iPhone Notification 20pt @2x @3x
  { name: 'ios-Icon-20@2x.png', size: 40 },
  { name: 'ios-Icon-20@3x.png', size: 60 },
  // iPhone Settings 29pt @2x @3x
  { name: 'ios-Icon-29@2x.png', size: 58 },
  { name: 'ios-Icon-29@3x.png', size: 87 },
  // iPhone Spotlight 40pt @2x @3x
  { name: 'ios-Icon-40@2x.png', size: 80 },
  { name: 'ios-Icon-40@3x.png', size: 120 },
  // iPhone App 60pt @2x @3x
  { name: 'ios-Icon-60@2x.png', size: 120 },
  { name: 'ios-Icon-60@3x.png', size: 180 },
  // iPad Notification 20pt @1x @2x
  { name: 'ios-Icon-20.png', size: 20 },
  { name: 'ios-Icon-20-ipad@2x.png', size: 40 },
  // iPad Settings 29pt @1x @2x
  { name: 'ios-Icon-29.png', size: 29 },
  { name: 'ios-Icon-29-ipad@2x.png', size: 58 },
  // iPad Spotlight 40pt @1x @2x
  { name: 'ios-Icon-40.png', size: 40 },
  { name: 'ios-Icon-40-ipad@2x.png', size: 80 },
  // iPad App 76pt @1x @2x
  { name: 'ios-Icon-76.png', size: 76 },
  { name: 'ios-Icon-76@2x.png', size: 152 },
  // iPad Pro App 83.5pt @2x
  { name: 'ios-Icon-83.5@2x.png', size: 167 },
  // App Store Marketing 1024
  { name: 'ios-Icon-1024.png', size: 1024 },
];

const svgBuffer = fs.readFileSync(SOURCE);
console.log(`Source: ${SOURCE} (${svgBuffer.length} bytes)`);

(async () => {
  for (const { name, size } of sizes) {
    const out = path.join(OUTPUT_DIR, name);
    await sharp(svgBuffer, { density: 600 })
      .resize(size, size, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png({ compressionLevel: 9, quality: 100 })
      .toFile(out);
    const stat = fs.statSync(out);
    console.log(`✓ ${name.padEnd(36)} ${`${size}x${size}`.padEnd(10)} ${stat.size} bytes`);
  }
  console.log(`\nDone. ${sizes.length} files generated in ${OUTPUT_DIR}/`);
})().catch(e => { console.error(e); process.exit(1); });
