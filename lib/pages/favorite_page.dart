import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/theme_provider.dart';
import '../models/favorite_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // ── Warna tema ──────────────────────────────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadFavorites();
    });
  }

  void _loadFavorites() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.userId == null) return;
    Provider.of<FavoriteProvider>(
      context,
      listen: false,
    ).loadFavorites(userId: authProvider.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          // ── Header ─────────────────────────────────────────
          _buildHeader(),

          // ── Body ───────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: _bodyBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: Consumer2<FavoriteProvider, ThemeProvider>(
                  builder: (context, favoriteProvider, themeProvider, _) {
                    if (favoriteProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: _blue),
                      );
                    }

                    if (favoriteProvider.favorites.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
                      itemCount: favoriteProvider.favorites.length,
                      itemBuilder: (context, index) {
                        final favorite = favoriteProvider.favorites[index];
                        return FavoriteCard(
                          favorite: favorite,
                          onRemove: () => _removeFavorite(favorite),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: _navyDark,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.of(context).padding.top + 18,
        22,
        28,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tempat yang kamu suka ❤️',
                  style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13),
                ),
                SizedBox(height: 4),
                Text(
                  'Destinasi Favorit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.13),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE ───────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.favorite_outline_rounded,
              size: 40,
              color: Color(0xFFC62828),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Favorit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tambahkan destinasi wisata ke favorit kamu',
            style: TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ],
      ),
    );
  }

  // ── DIALOG HAPUS (logika tidak berubah) ───────────────────
  void _removeFavorite(FavoriteModel favorite) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus Favorit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _navy,
          ),
        ),
        content: Text(
          'Hapus ${favorite.destinationName} dari favorit?',
          style: const TextStyle(fontSize: 13, color: Color(0xFF4A6080)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF99AABB)),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<FavoriteProvider>(
                context,
                listen: false,
              ).removeFavorite(destinationId: favorite.destinationId).then((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dihapus dari favorit'),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
            },
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: Color(0xFFC62828),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── FAVORITE CARD ──────────────────────────────────────────────
class FavoriteCard extends StatelessWidget {
  final FavoriteModel favorite;
  final VoidCallback onRemove;

  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);

  const FavoriteCard({
    super.key,
    required this.favorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EFF8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Gambar ────────────────────────────────────────
          if (favorite.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Image.network(
                favorite.imageUrl!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0D2B55), Color(0xFF1565C0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white54,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 90,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D2B55), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: const Center(
                child: Icon(
                  Icons.landscape_rounded,
                  color: Colors.white54,
                  size: 32,
                ),
              ),
            ),

          // ── Konten ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama + tombol hapus
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favorite.destinationName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _navy,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (favorite.kategori != null) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                favorite.kategori!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: _blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFC62828),
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                // Rating
                if (favorite.rating != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${favorite.rating} / 5.0',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE8EFF8)),
                const SizedBox(height: 12),

                // Tombol lihat detail
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.explore_rounded, size: 16),
                    label: const Text('Lihat Detail'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _navyDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      // Navigate to destination detail
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
