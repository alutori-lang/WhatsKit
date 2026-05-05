import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/app_colors.dart';

class TextFormatterScreen extends StatefulWidget {
  const TextFormatterScreen({super.key});

  @override
  State<TextFormatterScreen> createState() => _TextFormatterScreenState();
}

class _TextFormatterScreenState extends State<TextFormatterScreen> {
  final _controller = TextEditingController(text: 'Hello WhatsApp');
  String? _justCopied;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const _normal = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String _convert(String input, String mapping) {
    final mappedRunes = mapping.runes.toList();
    return input.split('').map((c) {
      final idx = _normal.indexOf(c);
      if (idx == -1 || idx >= mappedRunes.length) return c;
      return String.fromCharCode(mappedRunes[idx]);
    }).join();
  }

  String _bold(String s) =>
      _convert(s, '𝐚𝐛𝐜𝐝𝐞𝐟𝐠𝐡𝐢𝐣𝐤𝐥𝐦𝐧𝐨𝐩𝐪𝐫𝐬𝐭𝐮𝐯𝐰𝐱𝐲𝐳𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙𝟎𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗');
  String _italic(String s) =>
      _convert(s, '𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍0123456789');
  String _boldItalic(String s) =>
      _convert(s, '𝒂𝒃𝒄𝒅𝒆𝒇𝒈𝒉𝒊𝒋𝒌𝒍𝒎𝒏𝒐𝒑𝒒𝒓𝒔𝒕𝒖𝒗𝒘𝒙𝒚𝒛𝑨𝑩𝑪𝑫𝑬𝑭𝑮𝑯𝑰𝑱𝑲𝑳𝑴𝑵𝑶𝑷𝑸𝑹𝑺𝑻𝑼𝑽𝑾𝑿𝒀𝒁0123456789');
  String _script(String s) =>
      _convert(s, '𝓪𝓫𝓬𝓭𝓮𝓯𝓰𝓱𝓲𝓳𝓴𝓵𝓶𝓷𝓸𝓹𝓺𝓻𝓼𝓽𝓾𝓿𝔀𝔁𝔂𝔃𝓐𝓑𝓒𝓓𝓔𝓕𝓖𝓗𝓘𝓙𝓚𝓛𝓜𝓝𝓞𝓟𝓠𝓡𝓢𝓣𝓤𝓥𝓦𝓧𝓨𝓩0123456789');
  String _gothic(String s) =>
      _convert(s, '𝖆𝖇𝖈𝖉𝖊𝖋𝖌𝖍𝖎𝖏𝖐𝖑𝖒𝖓𝖔𝖕𝖖𝖗𝖘𝖙𝖚𝖛𝖜𝖝𝖞𝖟𝕬𝕭𝕮𝕯𝕰𝕱𝕲𝕳𝕴𝕵𝕶𝕷𝕸𝕹𝕺𝕻𝕼𝕽𝕾𝕿𝖀𝖁𝖂𝖃𝖄𝖅0123456789');
  String _doubleStruck(String s) =>
      _convert(s, '𝕒𝕓𝕔𝕕𝕖𝕗𝕘𝕙𝕚𝕛𝕜𝕝𝕞𝕟𝕠𝕡𝕢𝕣𝕤𝕥𝕦𝕧𝕨𝕩𝕪𝕫𝔸𝔹ℂ𝔻𝔼𝔽𝔾ℍ𝕀𝕁𝕂𝕃𝕄ℕ𝕆ℙℚℝ𝕊𝕋𝕌𝕍𝕎𝕏𝕐ℤ𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡');
  String _mono(String s) =>
      _convert(s, '𝚊𝚋𝚌𝚍𝚎𝚏𝚐𝚑𝚒𝚓𝚔𝚕𝚖𝚗𝚘𝚙𝚚𝚛𝚜𝚝𝚞𝚟𝚠𝚡𝚢𝚣𝙰𝙱𝙲𝙳𝙴𝙵𝙶𝙷𝙸𝙹𝙺𝙻𝙼𝙽𝙾𝙿𝚀𝚁𝚂𝚃𝚄𝚅𝚆𝚇𝚈𝚉𝟶𝟷𝟸𝟹𝟺𝟻𝟼𝟽𝟾𝟿');
  String _sans(String s) =>
      _convert(s, '𝖺𝖻𝖼𝖽𝖾𝖿𝗀𝗁𝗂𝗃𝗄𝗅𝗆𝗇𝗈𝗉𝗊𝗋𝗌𝗍𝗎𝗏𝗐𝗑𝗒𝗓𝖠𝖡𝖢𝖣𝖤𝖥𝖦𝖧𝖨𝖩𝖪𝖫𝖬𝖭𝖮𝖯𝖰𝖱𝖲𝖳𝖴𝖵𝖶𝖷𝖸𝖹𝟢𝟣𝟤𝟥𝟦𝟧𝟨𝟩𝟪𝟫');
  String _circled(String s) =>
      _convert(s, 'ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ⓪①②③④⑤⑥⑦⑧⑨');
  String _filled(String s) =>
      _convert(s, '🅐🅑🅒🅓🅔🅕🅖🅗🅘🅙🅚🅛🅜🅝🅞🅟🅠🅡🅢🅣🅤🅥🅦🅧🅨🅩🅐🅑🅒🅓🅔🅕🅖🅗🅘🅙🅚🅛🅜🅝🅞🅟🅠🅡🅢🅣🅤🅥🅦🅧🅨🅩0123456789');
  String _square(String s) =>
      _convert(s, '🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉0123456789');
  String _wide(String s) {
    return s.split('').map((c) {
      final code = c.codeUnitAt(0);
      if (code >= 0x21 && code <= 0x7E) {
        return String.fromCharCode(code + 0xFEE0);
      }
      if (code == 0x20) return '　';
      return c;
    }).join();
  }
  String _spaced(String s) => s.split('').join(' ');
  String _smallCaps(String s) =>
      _convert(s, 'ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡxʏᴢABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');

  // ===== DECORATED STYLES (colorful with emoji symbols) =====
  String _flag(String s) {
    // Regional indicator letters - render as colorful flag pairs on Android
    return s.split('').map((c) {
      final code = c.toUpperCase().codeUnitAt(0);
      if (code >= 65 && code <= 90) {
        // A-Z → regional indicator U+1F1E6 + (code - 65)
        return '${String.fromCharCode(0x1F1E6 + (code - 65))} ';
      }
      return '$c ';
    }).join().trimRight();
  }

  String _sparkleEach(String s) =>
      '✨ ${s.split('').join(' ✨ ')} ✨';
  String _heartEach(String s) =>
      '❤️ ${s.split('').join(' ❤️ ')} ❤️';
  String _starEach(String s) =>
      '⭐ ${s.split('').join(' ⭐ ')} ⭐';
  String _fireEach(String s) =>
      '🔥 ${s.split('').join(' 🔥 ')} 🔥';
  String _flowerEach(String s) =>
      '🌸 ${s.split('').join(' 🌸 ')} 🌸';

  String _crownWrap(String s) => '👑 ・ $s ・ 👑';
  String _heartWrap(String s) => '╰┈➤ $s ❤️';
  String _diamondWrap(String s) => '💎 ✦ $s ✦ 💎';
  String _waveWrap(String s) => '꧁ $s ꧂';
  String _arrowWrap(String s) => '➶❥ $s ❥➷';
  String _starsWrap(String s) => '★彡 $s 彡★';
  String _butterfly(String s) => '🦋 ${s.split('').join('・')} 🦋';
  String _moonWrap(String s) => '✦ ☾ $s ☽ ✦';
  String _quoteWrap(String s) => '" ✧ $s ✧ "';

  // Frame box (multiline)
  String _frameBox(String s) {
    final width = s.length + 4;
    final top = '╔${'═' * width}╗';
    final mid = '║  $s  ║';
    final bot = '╚${'═' * width}╝';
    return '$top\n$mid\n$bot';
  }
  String _doubleFrame(String s) {
    final width = s.length + 4;
    return '┌${'─' * width}┐\n│  $s  │\n└${'─' * width}┘';
  }

  // Combining characters (strikethrough, underline)
  String _strikethrough(String s) =>
      s.split('').map((c) => '$c̶').join();
  String _underline(String s) =>
      s.split('').map((c) => '$c̲').join();
  String _doubleUnderline(String s) =>
      s.split('').map((c) => '$c̳').join();
  String _overline(String s) =>
      s.split('').map((c) => '$c̅').join();

  // Reverse / upside down (basic)
  String _reverse(String s) => s.split('').reversed.join();

  Future<void> _copy(String value, String name) async {
    HapticFeedback.lightImpact();
    await Clipboard.setData(ClipboardData(text: value));
    setState(() => _justCopied = name);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted && _justCopied == name) {
      setState(() => _justCopied = null);
    }
  }

  Future<void> _share(String value) async {
    HapticFeedback.selectionClick();
    await Share.share(value);
  }

  @override
  Widget build(BuildContext context) {
    final input = _controller.text.isEmpty ? 'Hello' : _controller.text;
    final fonts = <Map<String, String>>[
      // ===== FANCY UNICODE FONTS =====
      {'name': '𝐁𝐨𝐥𝐝', 'value': _bold(input)},
      {'name': '𝐼𝑡𝑎𝑙𝑖𝑐', 'value': _italic(input)},
      {'name': '𝑩𝒐𝒍𝒅 𝑰𝒕𝒂𝒍𝒊𝒄', 'value': _boldItalic(input)},
      {'name': '𝓢𝓬𝓻𝓲𝓹𝓽', 'value': _script(input)},
      {'name': '𝕲𝖔𝖙𝖍𝖎𝖈', 'value': _gothic(input)},
      {'name': '𝔻𝕠𝕦𝕓𝕝𝕖 𝕊𝕥𝕣𝕦𝕔𝕜', 'value': _doubleStruck(input)},
      {'name': '𝖲𝖺𝗇𝗌 𝖲𝖾𝗋𝗂𝖿', 'value': _sans(input)},
      {'name': '𝙼𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎', 'value': _mono(input)},
      {'name': 'sᴍᴀʟʟ ᴄᴀᴘs', 'value': _smallCaps(input)},
      {'name': 'Ⓒⓘⓡⓒⓛⓔⓓ', 'value': _circled(input)},
      {'name': '🅕🅘🅛🅛🅔🅓', 'value': _filled(input)},
      {'name': '🄶🅀🅄🄰🅁🄴🄳', 'value': _square(input)},
      {'name': 'Full Width', 'value': _wide(input)},
      {'name': 'S p a c e d', 'value': _spaced(input)},

      // ===== COLORFUL EMOJI FLAGS =====
      {'name': '🇫🇱🇦🇬 Flag Letters', 'value': _flag(input)},

      // ===== DECORATED WITH SYMBOLS =====
      {'name': '✨ Sparkle Each', 'value': _sparkleEach(input)},
      {'name': '❤️ Heart Each', 'value': _heartEach(input)},
      {'name': '⭐ Star Each', 'value': _starEach(input)},
      {'name': '🔥 Fire Each', 'value': _fireEach(input)},
      {'name': '🌸 Flower Each', 'value': _flowerEach(input)},
      {'name': '🦋 Butterfly', 'value': _butterfly(input)},

      // ===== WRAPPED STYLES =====
      {'name': '👑 Crown', 'value': _crownWrap(input)},
      {'name': '╰┈➤ Heart Arrow', 'value': _heartWrap(input)},
      {'name': '💎 Diamond', 'value': _diamondWrap(input)},
      {'name': '꧁ ꧂ Royal Wave', 'value': _waveWrap(input)},
      {'name': '➶❥ Arrow Heart', 'value': _arrowWrap(input)},
      {'name': '★彡 Stars', 'value': _starsWrap(input)},
      {'name': '☾ ☽ Moon', 'value': _moonWrap(input)},
      {'name': '" ✧ Quote ✧ "', 'value': _quoteWrap(input)},

      // ===== FRAME BOXES =====
      {'name': '╔═╗ Frame Double', 'value': _frameBox(input)},
      {'name': '┌─┐ Frame Light', 'value': _doubleFrame(input)},

      // ===== COMBINING (strike, underline) =====
      {'name': 'S̶t̶r̶i̶k̶e̶t̶h̶r̶o̶u̶g̶h̶', 'value': _strikethrough(input)},
      {'name': 'U̲n̲d̲e̲r̲l̲i̲n̲e̲', 'value': _underline(input)},
      {'name': 'D̳o̳u̳b̳l̳e̳ ̳U̳n̳d̳e̳r̳l̳i̳n̳e̳', 'value': _doubleUnderline(input)},
      {'name': 'O̅v̅e̅r̅l̅i̅n̅e̅', 'value': _overline(input)},

      // ===== REVERSE =====
      {'name': '◀ Reverse', 'value': _reverse(input)},

      // ===== WHATSAPP MARKDOWN =====
      {'name': '*WhatsApp Bold*', 'value': '*$input*'},
      {'name': '_WhatsApp Italic_', 'value': '_${input}_'},
      {'name': '~WhatsApp Strike~', 'value': '~$input~'},
      {'name': '```WhatsApp Mono```', 'value': '```$input```'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Text Tools',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            tooltip: 'Cancella testo',
            onPressed: () {
              setState(() => _controller.clear());
              HapticFeedback.lightImpact();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: AppColors.bgPrimary,
            child: TextField(
              controller: _controller,
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'Scrivi il tuo testo...',
                prefixIcon: Icon(Icons.edit_outlined, size: 18),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: const BoxDecoration(
              color: AppColors.bgPage,
              border: Border(
                top: BorderSide(color: AppColors.divider),
                bottom: BorderSide(color: AppColors.divider),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.style, size: 14, color: AppColors.waGreenDark),
                const SizedBox(width: 6),
                Text(
                  '${fonts.length} stili disponibili',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.waGreenDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Tap COPY per copiare',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: fonts.length,
              itemBuilder: (context, i) {
                final font = fonts[i];
                final justCopied = _justCopied == font['name'];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: justCopied
                        ? AppColors.waGreen.withValues(alpha: 0.15)
                        : AppColors.bgPage,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: justCopied ? AppColors.waGreen : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              font['name']!,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Spacer(),
                            if (justCopied)
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, color: AppColors.waGreen, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'COPIATO',
                                    style: TextStyle(
                                      color: AppColors.waGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                font['value']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                  height: 1.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _iconBtn(
                              icon: Icons.copy_outlined,
                              color: AppColors.waGreen,
                              onTap: () => _copy(font['value']!, font['name']!),
                            ),
                            const SizedBox(width: 6),
                            _iconBtn(
                              icon: Icons.share,
                              color: AppColors.waGreenDark,
                              onTap: () => _share(font['value']!),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
