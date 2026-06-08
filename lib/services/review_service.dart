import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/review_model.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const _uuid = Uuid();

  // Create review
  Future<ReviewModel> createReview({
    required String destinationId,
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required double rating,
    required String comment,
    List<String> imageUrls = const [],
  }) async {
    try {
      final reviewId = _uuid.v4();
      final now = DateTime.now();

      final review = ReviewModel(
        id: reviewId,
        userId: userId,
        userName: userName,
        userPhotoUrl: userPhotoUrl,
        destinationId: destinationId,
        rating: rating,
        comment: comment,
        imageUrls: imageUrls,
        createdAt: now,
        updatedAt: now,
      );

      await _firestore.collection('reviews').doc(reviewId).set(review.toJson());

      // Update destination average rating
      await _updateDestinationRating(destinationId);

      return review;
    } catch (e) {
      throw Exception('Gagal membuat review: $e');
    }
  }

  // Get destination reviews
  Future<List<ReviewModel>> getDestinationReviews({
    required String destinationId,
    int limit = 50,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan review: $e');
    }
  }

  // Get user reviews
  Future<List<ReviewModel>> getUserReviews({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan review user: $e');
    }
  }

  // Get review by ID
  Future<ReviewModel?> getReviewById({required String reviewId}) async {
    try {
      final doc = await _firestore.collection('reviews').doc(reviewId).get();

      if (!doc.exists) return null;

      return ReviewModel.fromJson(doc.id, doc.data()!);
    } catch (e) {
      throw Exception('Gagal mendapatkan review: $e');
    }
  }

  // Update review
  Future<void> updateReview({
    required String reviewId,
    String? comment,
    double? rating,
  }) async {
    try {
      await _firestore.collection('reviews').doc(reviewId).update({
        'comment': ?comment,
        'rating': ?rating,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Gagal mengubah review: $e');
    }
  }

  // Delete review
  Future<void> deleteReview({
    required String reviewId,
    required String destinationId,
  }) async {
    try {
      await _firestore.collection('reviews').doc(reviewId).delete();

      // Update destination rating
      await _updateDestinationRating(destinationId);
    } catch (e) {
      throw Exception('Gagal menghapus review: $e');
    }
  }

  // Mark review as helpful
  Future<void> markHelpful({
    required String reviewId,
    required String userId,
  }) async {
    try {
      final review = await getReviewById(reviewId: reviewId);
      if (review == null) throw Exception('Review tidak ditemukan');

      List<String> helpfulUsers = List.from(review.helpfulUsers);
      if (!helpfulUsers.contains(userId)) {
        helpfulUsers.add(userId);
        await _firestore.collection('reviews').doc(reviewId).update({
          'helpfulCount': review.helpfulCount + 1,
          'helpfulUsers': helpfulUsers,
        });
      }
    } catch (e) {
      throw Exception('Gagal menandai review sebagai helpful: $e');
    }
  }

  // Get average rating for destination
  Future<double> getAverageRating({required String destinationId}) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .get();

      if (snapshot.docs.isEmpty) return 0;

      double totalRating = 0;
      for (var doc in snapshot.docs) {
        totalRating += (doc.data()['rating'] as num).toDouble();
      }

      return totalRating / snapshot.docs.length;
    } catch (e) {
      throw Exception('Gagal mendapatkan rating rata-rata: $e');
    }
  }

  // Get rating distribution
  Future<Map<int, int>> getRatingDistribution({
    required String destinationId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .get();

      Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

      for (var doc in snapshot.docs) {
        final rating = (doc.data()['rating'] as num).toInt();
        distribution[rating] = (distribution[rating] ?? 0) + 1;
      }

      return distribution;
    } catch (e) {
      throw Exception('Gagal mendapatkan distribusi rating: $e');
    }
  }

  // Get reviews with pagination
  Future<List<ReviewModel>> getReviewsWithPagination({
    required String destinationId,
    required int pageNumber,
    int pageSize = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .orderBy('createdAt', descending: true)
          .limit(pageSize)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan review dengan pagination: $e');
    }
  }

  // Filter reviews by rating
  Future<List<ReviewModel>> filterByRating({
    required String destinationId,
    required int minRating,
    required int maxRating,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .where('rating', isGreaterThanOrEqualTo: minRating)
          .where('rating', isLessThanOrEqualTo: maxRating)
          .orderBy('rating', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Gagal memfilter review: $e');
    }
  }

  // Search reviews
  Future<List<ReviewModel>> searchReviews({
    required String destinationId,
    required String query,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.id, doc.data()))
          .where(
            (review) =>
                review.comment.toLowerCase().contains(query.toLowerCase()) ||
                review.userName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      throw Exception('Gagal mencari review: $e');
    }
  }

  // Private helper method
  Future<void> _updateDestinationRating(String destinationId) async {
    try {
      final averageRating = await getAverageRating(
        destinationId: destinationId,
      );

      final reviewCount = await _firestore
          .collection('reviews')
          .where('destinationId', isEqualTo: destinationId)
          .get()
          .then((snap) => snap.size);

      // Update destination document
      await _firestore.collection('destinations').doc(destinationId).update({
        'rating': averageRating,
        'reviewCount': reviewCount,
      });
    } catch (e) {
      print('Error updating destination rating: $e');
    }
  }
}
