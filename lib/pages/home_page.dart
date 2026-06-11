import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/favorite_provider.dart';
import 'booking_page.dart';
import 'review_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ── Warna tema ──────────────────────────────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  // ── State ────────────────────────────────────────────────────
  int _activeKat = 0;
  int _activeTab = 0;

  // ── Search State ─────────────────────────────────────────────
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();

  // ── Data Kategori ────────────────────────────────────────────
  static const List<Map<String, dynamic>> _categories = [
    {'icon': Icons.apps_rounded, 'label': 'Semua', 'color': Color(0xFF4CAF50)},
    {'icon': Icons.forest_rounded, 'label': 'Alam', 'color': Color(0xFF388E3C)},
    {
      'icon': Icons.water_drop_rounded,
      'label': 'Air Terjun',
      'color': Color(0xFF0288D1),
    },
    {
      'icon': Icons.waves_rounded,
      'label': 'Kolam & DAM',
      'color': Color(0xFF00ACC1),
    },
    {
      'icon': Icons.terrain_rounded,
      'label': 'Bukit',
      'color': Color(0xFF546E7A),
    },
    {
      'icon': Icons.local_florist_rounded,
      'label': 'Taman',
      'color': Color(0xFF7B1FA2),
    },
    {
      'icon': Icons.outdoor_grill_rounded,
      'label': 'Camping',
      'color': Color(0xFFE65100),
    },
  ];

  // ── Tab Populer ──────────────────────────────────────────────
  static const List<String> _tabs = ['Terpopuler', 'Terdekat', 'Terbaru'];

  // ── Popular Cards ────────────────────────────────────────────
  static const List<Map<String, dynamic>> _popularCards = [
    {
      'id': 'gisting_idaman_hill',
      'icon': Icons.terrain_rounded,
      'image': 'assets/Gisting_Idaman_Hill.jpg',
      'color': Color(0xFF1565C0),
      'name': 'Gisting Idaman Hill',
      'sub': 'Wisata Perbukitan',
      'rating': 4.8,
      'category': 'Bukit',
    },
    {
      'id': 'bukit_neba',
      'icon': Icons.outdoor_grill_rounded,
      'image': 'assets/Bukit_Neba.jpg',
      'color': Color(0xFF37474F),
      'name': 'Bukit Neba',
      'sub': 'Camping & Panorama',
      'rating': 4.7,
      'category': 'Camping',
    },
    {
      'id': 'air_terjun_batu_lapis',
      'icon': Icons.water_drop_rounded,
      'image': 'assets/Air_Terjun_Batu_Lapis.jpg',
      'color': Color(0xFF1B5E20),
      'name': 'Air Terjun Batu Lapis',
      'sub': 'Air Terjun Unik',
      'rating': 4.7,
      'category': 'Air Terjun',
    },
    {
      'id': 'lentana_garden',
      'icon': Icons.local_florist_rounded,
      'image': 'assets/Lentana_Garden.jpg',
      'color': Color(0xFF7B1FA2),
      'name': 'Lentana Garden',
      'sub': 'Taman Keluarga',
      'rating': 4.6,
      'category': 'Taman',
    },
    {
      'id': 'dam_margo_tirto',
      'icon': Icons.waves_rounded,
      'image': 'assets/Wisata_DAM_Margo_Tirto.jpeg',
      'color': Color(0xFF0288D1),
      'name': 'DAM Margo Tirto',
      'sub': 'Wisata Air',
      'rating': 4.5,
      'category': 'Kolam & DAM',
    },
  ];

  // ── Semua Destinasi ──────────────────────────────────────────
  static const List<Map<String, dynamic>> _destinations = [
    {
      'id': 'gisting_idaman_hill',
      'name': 'Gisting Idaman Hill',
      'desc': 'Panorama Gunung Tanggamus & spot foto',
      'category': 'Bukit',
      'catStyle': 'bukit',
      'price': 10000.0,
      'rating': 4.8,
      'icon': Icons.terrain_rounded,
      'image': 'assets/Gisting_Idaman_Hill.jpg',
      'iconColor': Color(0xFF1565C0),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'id': 'bukit_neba',
      'name': 'Bukit Neba',
      'desc': 'Camping & pemandangan dari ketinggian',
      'category': 'Camping',
      'catStyle': 'bukit',
      'price': 15000.0,
      'rating': 4.7,
      'icon': Icons.outdoor_grill_rounded,
      'image': 'assets/Bukit_Neba.jpg',
      'iconColor': Color(0xFF455A64),
      'bgColor': Color(0xFFECEFF1),
    },
    {
      'id': 'rest_area_park',
      'name': 'Rest Area Park Gisting',
      'desc': 'Taman santai udara sejuk pegunungan',
      'category': 'Taman',
      'catStyle': 'taman',
      'price': 0.0,
      'rating': 4.4,
      'icon': Icons.forest_rounded,
      'image': 'assets/Rest_Area_Park_Gisting.webp',
      'iconColor': Color(0xFF2E7D32),
      'bgColor': Color(0xFFE8F5E9),
    },
    {
      'id': 'lentana_garden',
      'name': 'Lentana Garden',
      'desc': 'Kolam renang, taman bunga & wahana',
      'category': 'Taman',
      'catStyle': 'taman',
      'price': 20000.0,
      'rating': 4.6,
      'icon': Icons.local_florist_rounded,
      'image': 'assets/Lentana_Garden.jpg',
      'iconColor': Color(0xFF6A1B9A),
      'bgColor': Color(0xFFEDE7F6),
    },
    {
      'id': 'dam_margo_tirto',
      'name': 'Wisata DAM Margo Tirto',
      'desc': 'Area bermain & tempat bersantai di air',
      'category': 'Kolam & DAM',
      'catStyle': 'kolam',
      'price': 10000.0,
      'rating': 4.5,
      'icon': Icons.waves_rounded,
      'image': 'assets/Wisata_DAM_Margo_Tirto.jpeg',
      'iconColor': Color(0xFF00695C),
      'bgColor': Color(0xFFE0F7FA),
    },
    {
      'id': 'butterfly_pool',
      'name': 'Butterfly Swimming Pool',
      'desc': 'Kolam renang wisata keluarga populer',
      'category': 'Kolam',
      'catStyle': 'kolam',
      'price': 15000.0,
      'rating': 4.5,
      'icon': Icons.pool_rounded,
      'image': 'assets/butterfly_swimming_pool.jpg',
      'iconColor': Color(0xFF00695C),
      'bgColor': Color(0xFFE0F7FA),
    },
    {
      'id': 'way_bekhak',
      'name': 'Way Bekhak Bath Sukaraja',
      'desc': 'Pemandian mata air jernih & sejuk',
      'category': 'Air',
      'catStyle': 'air',
      'price': 5000.0,
      'rating': 4.6,
      'icon': Icons.water_drop_rounded,
      'image': 'assets/Way_Bekhak_Bath_Sukaraja.jpg',
      'iconColor': Color(0xFF1B5E20),
      'bgColor': Color(0xFFE8F5E9),
    },
    {
      'id': 'air_terjun_batu_lapis',
      'name': 'Air Terjun Batu Lapis',
      'desc': 'Formasi batu bertingkat yang unik',
      'category': 'Air Terjun',
      'catStyle': 'air',
      'price': 10000.0,
      'rating': 4.7,
      'icon': Icons.waterfall_chart_rounded,
      'image': 'assets/Air_Terjun_Batu_Lapis.jpg',
      'iconColor': Color(0xFF1565C0),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'id': 'air_terjun_keramat_sari',
      'name': 'Air Terjun Keramat Sari',
      'desc': 'Cocok untuk trekking ringan',
      'category': 'Air Terjun',
      'catStyle': 'air',
      'price': 5000.0,
      'rating': 4.5,
      'icon': Icons.waterfall_chart_rounded,
      'image': 'assets/Air_Terjun_Keramat_Sari.jpeg',
      'iconColor': Color(0xFF1565C0),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'id': 'gunung_tanggamus',
      'name': 'Gunung Tanggamus',
      'desc': 'Pendakian dengan pemandangan terbaik',
      'category': 'Petualangan',
      'catStyle': 'bukit',
      'price': 25000.0,
      'rating': 4.9,
      'icon': Icons.terrain_rounded,
      'image': 'assets/Gunung_Tanggamus.jpg',
      'iconColor': Color(0xFF455A64),
      'bgColor': Color(0xFFECEFF1),
    },
  ];

  // ── Helpers ───────────────────────────────────────────────────
  String _formatPrice(double price) {
    if (price == 0) return 'Gratis';
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  Map<String, Color> _badgeColors(String style) {
    switch (style) {
      case 'air':
        return {'bg': const Color(0xFFE0F7FA), 'fg': const Color(0xFF00695C)};
      case 'bukit':
        return {'bg': const Color(0xFFECEFF1), 'fg': const Color(0xFF455A64)};
      case 'taman':
        return {'bg': const Color(0xFFEDE7F6), 'fg': const Color(0xFF6A1B9A)};
      case 'kolam':
        return {'bg': const Color(0xFFE0F2F1), 'fg': const Color(0xFF00695C)};
      default:
        return {'bg': const Color(0xFFE3F2FD), 'fg': const Color(0xFF1565C0)};
    }
  }

  // ── Search Filter ─────────────────────────────────────────────
  List<Map<String, dynamic>> get _filteredDestinations {
    if (_searchQuery.isEmpty) return _destinations;
    final q = _searchQuery.toLowerCase();
    return _destinations.where((d) {
      return (d['name'] as String).toLowerCase().contains(q) ||
          (d['desc'] as String).toLowerCase().contains(q) ||
          (d['category'] as String).toLowerCase().contains(q);
    }).toList();
  }

  // ── initState ─────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _isSearching = _searchController.text.isNotEmpty;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.userId != null) {
        Provider.of<FavoriteProvider>(
          context,
          listen: false,
        ).loadFavorites(userId: authProvider.userId!);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // ── Toggle favorite dengan FavoriteProvider ───────────────────
  Future<void> _toggleFavorite(Map<String, dynamic> item) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final favProvider = Provider.of<FavoriteProvider>(context, listen: false);

    if (authProvider.userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login dulu untuk menyimpan favorit'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await favProvider.toggleFavorite(
        userId: authProvider.userId!,
        destinationId: item['id'] as String,
        destinationName: item['name'] as String,
        rating: (item['rating'] as num).toDouble(),
        kategori: item['category'] as String? ?? item['catStyle'] as String?,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengubah favorit: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          // ── Header ─────────────────────────────────────────────
          _buildHeader(auth),

          // ── Scrollable body ────────────────────────────────────
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
                child: _isSearching
                    ? _buildSearchResults(auth.isLoggedIn)
                    : SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionHeader('Kategori', 'Jelajahi'),
                                  const SizedBox(height: 13),
                                  _buildCategories(),
                                  const SizedBox(height: 22),
                                  _buildSectionHeader(
                                    'Destinasi Populer',
                                    'Lihat semua',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTabs(),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: _buildPopularCards(auth.isLoggedIn),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                18,
                                22,
                                18,
                                24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionHeader(
                                    'Semua Destinasi',
                                    'Lihat semua',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildDestinationList(auth.isLoggedIn),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────
  Widget _buildHeader(AuthProvider auth) {
    return Container(
      color: _navyDark,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.of(context).padding.top + 18,
        22,
        30,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.isLoggedIn
                          ? 'Halo, ${auth.userName?.split(' ').first ?? 'Wisatawan'}! 👋'
                          : 'Halo, Selamat datang 👋',
                      style: const TextStyle(
                        color: Color(0xAAFFFFFF),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Jelajahi Wisata\nGisting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
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
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // ── Search Bar AKTIF ──────────────────────────────────
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _searchFocusNode.hasFocus
                    ? Colors.white.withValues(alpha: 0.40)
                    : Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0x73FFFFFF),
                  size: 17,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: 'Cari destinasi wisata...',
                      hintStyle: TextStyle(
                        color: Color(0x8CFFFFFF),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      // optional: handle enter key
                    },
                  ),
                ),
                // Tombol clear (X) atau filter
                GestureDetector(
                  onTap: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchController.clear();
                      _searchFocusNode.unfocus();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Icon(
                      _isSearching ? Icons.close_rounded : Icons.tune_rounded,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── SEARCH RESULTS ────────────────────────────────────────────
  Widget _buildSearchResults(bool isLoggedIn) {
    final results = _filteredDestinations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                size: 16,
                color: Color(0xFF99AABB),
              ),
              const SizedBox(width: 6),
              Text(
                results.isEmpty
                    ? 'Tidak ada hasil untuk "$_searchQuery"'
                    : '${results.length} hasil untuk "$_searchQuery"',
                style: const TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
              ),
            ],
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 56,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Destinasi tidak ditemukan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Coba kata kunci lain',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                  itemCount: results.length,
                  itemBuilder: (_, index) {
                    final dest = results[index];
                    final badge = _badgeColors(dest['catStyle'] as String);
                    final price = dest['price'] as double;
                    return GestureDetector(
                      onTap: () {
                        _searchFocusNode.unfocus();
                        _showDetail(context, dest, isLoggedIn);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE8EFF8)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: dest['bgColor'] as Color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: dest['image'] != null
                                  ? Image.asset(
                                      dest['image'] as String,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      dest['icon'] as IconData,
                                      color: dest['iconColor'] as Color,
                                      size: 22,
                                    ),
                            ),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHighlightedText(
                                    dest['name'] as String,
                                    _searchQuery,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    dest['desc'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF99AABB),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: badge['bg'],
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                        ),
                                        child: Text(
                                          dest['category'] as String,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: badge['fg'],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFFFC107),
                                        size: 12,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${dest['rating']}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFFFFC107),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _formatPrice(price),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _blue,
                                  ),
                                ),
                                if (price > 0)
                                  const Text(
                                    '/orang',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFAABBC8),
                                    ),
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
    );
  }

  // ── Highlight teks sesuai query ───────────────────────────────
  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _navy,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerText.indexOf(lowerQuery);

    if (index == -1) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _navy,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _navy,
        ),
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: const TextStyle(
              color: _blue,
              backgroundColor: Color(0xFFDCEEFF),
            ),
          ),
          TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }

  // ── SECTION HEADER ────────────────────────────────────────────
  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _navy,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 12,
            color: _blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ── KATEGORI ──────────────────────────────────────────────────
  Widget _buildCategories() {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final kat = _categories[i];
          final color = kat['color'] as Color;
          final active = _activeKat == i;
          return GestureDetector(
            onTap: () => setState(() => _activeKat = i),
            child: SizedBox(
              width: 68,
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: active ? color : color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: active
                          ? Border.all(color: color, width: 2)
                          : Border.all(
                              color: color.withValues(alpha: 0.30),
                              width: 1,
                            ),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.40),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      kat['icon'] as IconData,
                      color: active ? Colors.white : color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    kat['label'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF4A6080),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── TABS ──────────────────────────────────────────────────────
  Widget _buildTabs() {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final active = _activeTab == i;
        return GestureDetector(
          onTap: () => setState(() => _activeTab = i),
          child: Container(
            margin: const EdgeInsets.only(right: 7),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: active ? _navyDark : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: active
                  ? null
                  : Border.all(color: const Color(0xFFDDEAF5)),
            ),
            child: Text(
              _tabs[i],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : const Color(0xFF99AABB),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ── POPULAR CARDS (horizontal scroll) ────────────────────────
  Widget _buildPopularCards(bool isLoggedIn) {
    const cardWidth = 130.0;

    final sorted = [..._popularCards];
    if (_activeTab == 0) {
      sorted.sort(
        (a, b) => (b['rating'] as double).compareTo(a['rating'] as double),
      );
    } else if (_activeTab == 1) {
      sorted.sort(
        (a, b) => (a['name'] as String).compareTo(b['name'] as String),
      );
    } else {
      sorted.sort(
        (a, b) => _popularCards.indexOf(b).compareTo(_popularCards.indexOf(a)),
      );
    }

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.only(right: 18),
        itemCount: sorted.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final card = sorted[i];
          return Consumer<FavoriteProvider>(
            builder: (context, favProvider, _) {
              final isFav = favProvider.isFavorite(card['id'] as String);
              return GestureDetector(
                onTap: () => _showDetail(
                  context,
                  _destinations.firstWhere(
                    (d) => d['id'] == card['id'],
                    orElse: () => _destinations[0],
                  ),
                  isLoggedIn,
                ),
                child: Container(
                  width: cardWidth,
                  decoration: BoxDecoration(
                    color: card['color'] as Color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: card['image'] != null
                            ? Image.asset(
                                card['image'] as String,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                card['icon'] as IconData,
                                color: Colors.white.withValues(alpha: 0.75),
                                size: 44,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(9, 20, 9, 8),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xAD000000), Colors.transparent],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                card['name'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                card['sub'] as String,
                                style: const TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFC107),
                                size: 10,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${card['rating']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(card),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFav
                                  ? const Color(0x66E53935)
                                  : Colors.white.withValues(alpha: 0.18),
                            ),
                            child: Icon(
                              isFav
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: isFav
                                  ? const Color(0xFFFF5252)
                                  : Colors.white,
                              size: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ── DESTINATION LIST ──────────────────────────────────────────
  Widget _buildDestinationList(bool isLoggedIn) {
    const Map<String, List<String>> katFilter = {
      'Semua': [],
      'Alam': ['Alam', 'Petualangan'],
      'Air Terjun': ['Air Terjun'],
      'Kolam & DAM': ['Kolam & DAM', 'Kolam'],
      'Bukit': ['Bukit', 'Camping', 'Petualangan'],
      'Taman': ['Taman'],
      'Camping': ['Camping'],
    };

    final activeLabel = _categories[_activeKat]['label'] as String;
    final keywords = katFilter[activeLabel] ?? [];
    final filtered = keywords.isEmpty
        ? _destinations
        : _destinations
              .where((d) => keywords.contains(d['category'] as String))
              .toList();

    if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'Belum ada destinasi di kategori ini.',
            style: TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ),
      );
    }

    return Column(
      children: filtered.map((dest) {
        final badge = _badgeColors(dest['catStyle'] as String);
        final price = dest['price'] as double;
        return GestureDetector(
          onTap: () => _showDetail(context, dest, isLoggedIn),
          child: Container(
            margin: const EdgeInsets.only(bottom: 9),
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE8EFF8)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: dest['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: dest['image'] != null
                      ? Image.asset(dest['image'] as String, fit: BoxFit.cover)
                      : Icon(
                          dest['icon'] as IconData,
                          color: dest['iconColor'] as Color,
                          size: 22,
                        ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dest['name'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _navy,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dest['desc'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF99AABB),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: badge['bg'],
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              dest['category'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: badge['fg'],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFC107),
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${dest['rating']}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFFC107),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatPrice(price),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _blue,
                      ),
                    ),
                    if (price > 0)
                      const Text(
                        '/orang',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFAABBC8),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── BOTTOM SHEET DETAIL ───────────────────────────────────────
  void _showDetail(
    BuildContext context,
    Map<String, dynamic> dest,
    bool isLoggedIn,
  ) {
    final price = dest['price'] as double;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Consumer<FavoriteProvider>(
        builder: (context, favProvider, _) {
          final isFav = favProvider.isFavorite(dest['id'] as String);
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            (dest['bgColor'] as Color?) ??
                            const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: dest['image'] != null
                          ? Image.asset(
                              dest['image'] as String,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              dest['icon'] as IconData,
                              color: (dest['iconColor'] as Color?) ?? _blue,
                              size: 26,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        dest['name'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _navy,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleFavorite(dest),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isFav
                              ? const Color(0xFFFFEBEE)
                              : const Color(0xFFF0F4FC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isFav
                                ? const Color(0xFFFFCDD2)
                                : const Color(0xFFE8EFF8),
                          ),
                        ),
                        child: Icon(
                          isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: isFav
                              ? const Color(0xFFC62828)
                              : const Color(0xFF99AABB),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  dest['desc'] as String,
                  style: const TextStyle(
                    color: Color(0xFF99AABB),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 16,
                    ),
                    Text(
                      '  ${dest['rating']}  ·  ',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      dest['category'] as String,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    if (price > 0) ...[
                      Text(
                        _formatPrice(price),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _blue,
                        ),
                      ),
                      const Text(
                        ' /orang',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFAABBC8),
                        ),
                      ),
                    ] else
                      const Text(
                        'Gratis',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.rate_review_outlined),
                        label: const Text('Ulasan'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _navyDark,
                          side: const BorderSide(color: Color(0xFFDDEAF5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReviewPage(
                                destinationId: dest['id'] as String,
                                destinationName: dest['name'] as String,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.confirmation_number_outlined),
                        label: const Text('Pesan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _navyDark,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        onPressed: isLoggedIn
                            ? () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookingPage(
                                      destinationId: dest['id'] as String,
                                      destinationName: dest['name'] as String,
                                      ticketPrice: dest['price'] as double,
                                    ),
                                  ),
                                );
                              }
                            : () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Silakan login terlebih dahulu.',
                                    ),
                                  ),
                                );
                              },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
