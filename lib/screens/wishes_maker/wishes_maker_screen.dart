import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/wish_card.dart';
import '../../theme/app_colors.dart';
import 'wish_detail_screen.dart';

class WishesMakerScreen extends StatefulWidget {
  final bool embedded;
  const WishesMakerScreen({super.key, this.embedded = false});

  @override
  State<WishesMakerScreen> createState() => _WishesMakerScreenState();
}

class _WishesMakerScreenState extends State<WishesMakerScreen> {
  String _selectedCategory = 'Trending';

  List<WishCard> get _filtered =>
      kAllWishes.where((w) => w.category == _selectedCategory).toList();

  void _openCreateMode(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const WishDetailScreen(createMode: true),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final body = _buildBody(s);
    if (widget.embedded) {
      return Stack(
        children: [
          body,
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              onPressed: () => _openCreateMode(context),
              icon: const Icon(Icons.edit),
              label: const Text('Crea Status'),
              backgroundColor: AppColors.waGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          s.wishesTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateMode(context),
        icon: const Icon(Icons.edit),
        label: const Text('Crea Status'),
        backgroundColor: AppColors.waGreen,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildBody(AppLocalizations s) {
    final categories = getCategories(s);
    return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: categories.map((c) {
                  final isActive = _selectedCategory == c['value'];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = c['value']!),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.waGreenDark : AppColors.bgPage,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isActive ? AppColors.waGreenDark : AppColors.divider,
                        ),
                      ),
                      child: Text(
                        c['label']!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _filtered.length,
              itemBuilder: (context, i) {
                final wish = _filtered[i];
                return _WishCardTile(
                  wish: wish,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => WishDetailScreen(wish: wish),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      );
  }
}

class _WishCardTile extends StatelessWidget {
  final WishCard wish;
  final VoidCallback onTap;

  const _WishCardTile({required this.wish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: wish.gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                wish.lang,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                wish.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      wish.likes,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.touch_app, color: Colors.white, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
