import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Takes a raw cutout (PNG with transparent background) and formats it as a
/// proper WhatsApp sticker: tight crop + optional white outline + centered
/// in 512x512 transparent canvas.
class StickerFormatter {
  static const int stickerSize = 512;

  /// Format raw cutout bytes as a WhatsApp sticker.
  static Uint8List formatAsSticker(
    Uint8List cutoutBytes, {
    bool whiteOutline = true,
    int outlinePx = 12,
  }) {
    final cutout = img.decodeImage(cutoutBytes);
    if (cutout == null) {
      throw Exception('Cutout non valido.');
    }

    // 1. Crop tight to subject bounding box
    final cropped = _cropTight(cutout);

    // 2. Fit subject to leave room for outline + canvas padding
    const padding = 8;
    final maxSubjectSize = stickerSize - 2 * (outlinePx + padding);

    img.Image scaled = cropped;
    if (cropped.width > maxSubjectSize || cropped.height > maxSubjectSize) {
      if (cropped.width >= cropped.height) {
        scaled = img.copyResize(
          cropped,
          width: maxSubjectSize,
          interpolation: img.Interpolation.cubic,
        );
      } else {
        scaled = img.copyResize(
          cropped,
          height: maxSubjectSize,
          interpolation: img.Interpolation.cubic,
        );
      }
    }

    // 3. Add white outline if enabled
    img.Image withOutline = scaled;
    if (whiteOutline) {
      withOutline = _addWhiteOutline(scaled, strokeWidth: outlinePx);
    }

    // 4. Center on 512x512 transparent canvas
    final canvas = img.Image(width: stickerSize, height: stickerSize, numChannels: 4);
    img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));
    final dx = (stickerSize - withOutline.width) ~/ 2;
    final dy = (stickerSize - withOutline.height) ~/ 2;
    img.compositeImage(canvas, withOutline, dstX: dx, dstY: dy);

    return Uint8List.fromList(img.encodePng(canvas));
  }

  /// Find tight bounding box of foreground pixels and crop.
  static img.Image _cropTight(img.Image image) {
    int minX = image.width;
    int minY = image.height;
    int maxX = 0;
    int maxY = 0;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        if (image.getPixel(x, y).a > 80) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (minX >= maxX || minY >= maxY) return image;

    return img.copyCrop(
      image,
      x: minX,
      y: minY,
      width: maxX - minX + 1,
      height: maxY - minY + 1,
    );
  }

  /// Add white outline around foreground (morphological dilation, circular).
  static img.Image _addWhiteOutline(img.Image input, {required int strokeWidth}) {
    final w = input.width;
    final h = input.height;
    final ow = w + 2 * strokeWidth;
    final oh = h + 2 * strokeWidth;
    final output = img.Image(width: ow, height: oh, numChannels: 4);
    img.fill(output, color: img.ColorRgba8(0, 0, 0, 0));

    final radiusSq = strokeWidth * strokeWidth;

    for (int y = 0; y < oh; y++) {
      for (int x = 0; x < ow; x++) {
        final ix = x - strokeWidth;
        final iy = y - strokeWidth;

        int selfAlpha = 0;
        if (ix >= 0 && ix < w && iy >= 0 && iy < h) {
          selfAlpha = input.getPixel(ix, iy).a.toInt();
        }

        if (selfAlpha > 80) {
          final p = input.getPixel(ix, iy);
          output.setPixelRgba(
              x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), p.a.toInt());
          continue;
        }

        bool nearFg = false;
        final yMin = (iy - strokeWidth).clamp(0, h - 1).toInt();
        final yMax = (iy + strokeWidth).clamp(0, h - 1).toInt();
        for (int yy = yMin; yy <= yMax && !nearFg; yy++) {
          final dy = yy - iy;
          final remSq = radiusSq - dy * dy;
          if (remSq < 0) continue;
          final dxMax = _isqrt(remSq);
          final xMin = (ix - dxMax).clamp(0, w - 1).toInt();
          final xMax = (ix + dxMax).clamp(0, w - 1).toInt();
          for (int xx = xMin; xx <= xMax; xx++) {
            if (input.getPixel(xx, yy).a > 80) {
              nearFg = true;
              break;
            }
          }
        }

        if (nearFg) {
          output.setPixelRgba(x, y, 255, 255, 255, 255);
        } else if (selfAlpha > 0) {
          final p = input.getPixel(ix, iy);
          output.setPixelRgba(
              x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), p.a.toInt());
        }
      }
    }

    return output;
  }

  static int _isqrt(int n) {
    if (n < 2) return n;
    int x = n;
    int y = (x + 1) >> 1;
    while (y < x) {
      x = y;
      y = (x + n ~/ x) >> 1;
    }
    return x;
  }
}
