// Convert SVG logo to PNG at multiple resolutions for Android launcher icons
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const SOURCE = process.argv[2] || 'logos/03-smile.svg';
const OUTPUT_DIR = process.argv[3] || 'output';

if (!fs.existsSync(OUTPUT_DIR)) fs.mkdirSync(OUTPUT_DIR, { recursive: true });

const sizes = [
  { name: 'icon-1024.png', size: 1024 },
  { name: 'icon-512.png', size: 512 },
  { name: 'mipmap-mdpi.png', size: 48 },
  { name: 'mipmap-hdpi.png', size: 72 },
  { name: 'mipmap-xhdpi.png', size: 96 },
  { name: 'mipmap-xxhdpi.png', size: 144 },
  { name: 'mipmap-xxxhdpi.png', size: 192 },
  // Adaptive icon foreground (108dp on each side, with 18dp safe zone padding)
  // We'll create the foreground PNG at high res; padding handled by Android XML
  { name: 'foreground-432.png', size: 432, density: 432 },
];

const svgBuffer = fs.readFileSync(SOURCE);
console.log(`Source: ${SOURCE} (${svgBuffer.length} bytes)`);

(async () => {
  for (const { name, size, density } of sizes) {
    const out = path.join(OUTPUT_DIR, name);
    await sharp(svgBuffer, { density: density || 600 })
      .resize(size, size, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png({ compressionLevel: 9, quality: 100 })
      .toFile(out);
    const stat = fs.statSync(out);
    console.log(`✓ ${name} (${size}x${size}, ${stat.size} bytes)`);
  }
  console.log('Done.');
})().catch(e => { console.error(e); process.exit(1); });
