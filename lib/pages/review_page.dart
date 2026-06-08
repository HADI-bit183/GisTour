import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../providers/auth_provider.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';

// Warna tema konsisten dengan HomePage & main.dart
const _navy = Color(0xFF0B1F3A);
const _navyDark = Color(0xFF0D2B55);
const _blue = Color(0xFF1565C0);
const _bodyBg = Color(0xFFF0F4FC);

class ReviewPage extends StatefulWidget {
  final String destinationId;
  final String destinationName;

  const ReviewPage({
    super.key,
    required this.destinationId,
    required this.destinationName,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late ReviewService _reviewService;
  List<ReviewModel> _reviews = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _reviewService = ReviewService();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    try {
      final reviews = await _reviewService.getDestinationReviews(
        destinationId: widget.destinationId,
      );
      setState(() {
        _reviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat review: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _initial(String? text, [String fallback = '?']) {
    if (text == null || text.isEmpty) return fallback;
    return text[0].toUpperCase();
  }

  // Rating rata-rata
  double get _avgRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        _reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: _bodyBg,
      appBar: AppBar(
        backgroundColor: _navyDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Review & Rating',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Info destinasi + rating summary ──
          _buildHeader(),

          // ── Tombol tulis review ──
          if (authProvider.isLoggedIn) _buildWriteReviewButton(authProvider),

          // ── List review ──
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: _blue))
                : _reviews.isEmpty
                ? _buildEmptyState()
                : _buildReviewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _navyDark,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            // Icon destinasi
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.place_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            // Nama & rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.destinationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _reviews.isEmpty
                            ? 'Belum ada review'
                            : '${_avgRating.toStringAsFixed(1)} · ${_reviews.length} ulasan',
                        style: const TextStyle(
                          color: Color(0xCCFFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWriteReviewButton(AuthProvider authProvider) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => CreateReviewSheet(
            destinationId: widget.destinationId,
            destinationName: widget.destinationName,
            userId: authProvider.userId ?? '',
            userName: authProvider.userName ?? 'User',
            onReviewCreated: _loadReviews,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDDEAF5)),
          boxShadow: [
            BoxShadow(
              color: _navy.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: _blue.withValues(alpha: 0.12),
              backgroundImage: authProvider.currentUser?.photoURL != null
                  ? NetworkImage(authProvider.currentUser!.photoURL!)
                  : null,
              child: authProvider.currentUser?.photoURL == null
                  ? Text(
                      _initial(
                        authProvider.currentUser?.displayName,
                        _initial(authProvider.userName, 'A'),
                      ),
                      style: const TextStyle(
                        color: _blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Bagikan pengalaman Anda...',
                style: TextStyle(color: Color(0xFF99AABB), fontSize: 13),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _navyDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Tulis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.rate_review_outlined,
              size: 36,
              color: _blue,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Jadilah yang pertama memberikan review',
            style: TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: _reviews[index]);
      },
    );
  }
}

// ── REVIEW CARD ───────────────────────────────────────────────
class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  String _initial(String text, [String fallback = '?']) {
    if (text.isEmpty) return fallback;
    return text[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EFF8)),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + nama + tanggal
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _blue.withValues(alpha: 0.12),
                backgroundImage: review.userPhotoUrl != null
                    ? NetworkImage(review.userPhotoUrl!)
                    : null,
                child: review.userPhotoUrl == null
                    ? Text(
                        _initial(review.userName),
                        style: const TextStyle(
                          color: _blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _navy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateFormat.format(review.createdAt),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF99AABB),
                      ),
                    ),
                  ],
                ),
              ),
              // Rating badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bintang
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < review.rating.toInt()
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: const Color(0xFFFFC107),
                size: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Komentar
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF4A6080),
            ),
          ),

          // Foto
          if (review.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: review.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        url,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 10),
          const Divider(color: Color(0xFFEEF2F8), height: 1),
          const SizedBox(height: 8),

          // Helpful
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${review.helpfulCount} orang terbantu',
                style: const TextStyle(fontSize: 11, color: Color(0xFF99AABB)),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 14,
                      color: _blue.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Membantu',
                      style: TextStyle(
                        fontSize: 11,
                        color: _blue.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── CREATE REVIEW SHEET ───────────────────────────────────────
class CreateReviewSheet extends StatefulWidget {
  final String destinationId;
  final String destinationName;
  final String userId;
  final String userName;
  final VoidCallback onReviewCreated;

  const CreateReviewSheet({
    super.key,
    required this.destinationId,
    required this.destinationName,
    required this.userId,
    required this.userName,
    required this.onReviewCreated,
  });

  @override
  State<CreateReviewSheet> createState() => _CreateReviewSheetState();
}

class _CreateReviewSheetState extends State<CreateReviewSheet> {
  late ReviewService _reviewService;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 5;
  final List<String> _imageUrls = [];
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _reviewService = ReviewService();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        setState(() => _imageUrls.add(image.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _submitReview() async {
    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan tulis komentar')));
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await _reviewService.createReview(
        destinationId: widget.destinationId,
        userId: widget.userId,
        userName: widget.userName,
        rating: _rating,
        comment: _commentController.text,
        imageUrls: _imageUrls,
      );
      if (mounted) {
        Navigator.pop(context);
        widget.onReviewCreated();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Review berhasil dibuat')));
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat review: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _bodyBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        builder: (context, scrollController) => Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE4F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header sheet
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tulis Review',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _navy,
                          ),
                        ),
                        Text(
                          widget.destinationName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF99AABB),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF99AABB),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEEF2F8)),

            // Form
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating
                    const Text(
                      'Rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _navy,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (i) {
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _rating = (i + 1).toDouble()),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Icon(
                                i < _rating.toInt()
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                size: 44,
                                color: i < _rating.toInt()
                                    ? const Color(0xFFFFC107)
                                    : const Color(0xFFDDE4F0),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Center(
                      child: Text(
                        [
                          '',
                          'Buruk',
                          'Kurang',
                          'Cukup',
                          'Bagus',
                          'Luar Biasa!',
                        ][_rating.toInt()],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFFA000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Komentar
                    const Text(
                      'Komentar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _navy,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _commentController,
                      maxLines: 5,
                      style: const TextStyle(fontSize: 13, color: _navy),
                      decoration: InputDecoration(
                        hintText: 'Bagikan pengalaman Anda...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF99AABB),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDDEAF5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDDEAF5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: _blue,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Foto
                    const Text(
                      'Foto (Opsional)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _navy,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._imageUrls.map((url) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  url,
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _imageUrls.remove(url)),
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFDDEAF5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Color(0xFF99AABB),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Tombol kirim
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _navyDark,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Kirim Review',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
