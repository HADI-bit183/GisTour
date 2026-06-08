import 'package:cloud_firestore/cloud_firestore.dart';
import 'location_service.dart';
import 'dart:math' as math;

class RecommendationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();

  // Get recommended destinations based on user preferences
  Future<List<Map<String, dynamic>>> getRecommendedDestinations({
    required String userId,
    required double userLat,
    required double userLng,
    int limit = 5,
  }) async {
    try {
      // Get user preferences from Firestore
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userPreferences = userDoc.data()?['preferences'] ?? {};
      final favoriteCategories = List<String>.from(
        (userPreferences['favoriteCategories'] as List?) ?? [],
      );

      // Get all destinations
      final destinationsSnapshot = await _firestore
          .collection('destinations')
          .get();

      // Score each destination
      List<Map<String, dynamic>> scoredDestinations = [];

      for (var doc in destinationsSnapshot.docs) {
        final destination = doc.data();
        double score = 0;

        // Score based on category match
        if (favoriteCategories.contains(destination['kategori'])) {
          score += 3;
        }

        // Score based on rating
        final rating = (destination['rating'] as num?)?.toDouble() ?? 0;
        score += rating / 5 * 2;

        // Score based on distance (closer = higher score)
        final distance = _locationService.calculateDistance(
          userLat: userLat,
          userLng: userLng,
          destinationLat: (destination['lat'] as num).toDouble(),
          destinationLng: (destination['lng'] as num).toDouble(),
        );
        score += math.max(0, 2 - (distance / 20)); // Max 2 points

        destination['score'] = score;
        destination['id'] = doc.id;
        destination['distance'] = distance;
        scoredDestinations.add(destination);
      }

      // Sort by score descending
      scoredDestinations.sort(
        (a, b) => (b['score'] as num).compareTo((a['score'] as num)),
      );

      return scoredDestinations.take(limit).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan rekomendasi: $e');
    }
  }

  // Get popular destinations (highest rated)
  Future<List<Map<String, dynamic>>> getPopularDestinations({
    int limit = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('destinations')
          .orderBy('rating', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan destinasi populer: $e');
    }
  }

  // Get nearby destinations
  Future<List<Map<String, dynamic>>> getNearbyDestinations({
    required double userLat,
    required double userLng,
    double radiusKm = 50, // Default 50 km radius
    int limit = 10,
  }) async {
    try {
      // Get all destinations (firestore doesn't have built-in geospatial queries)
      final snapshot = await _firestore.collection('destinations').get();

      List<Map<String, dynamic>> nearbyDestinations = [];

      for (var doc in snapshot.docs) {
        final destination = doc.data();
        final distance = _locationService.calculateDistance(
          userLat: userLat,
          userLng: userLng,
          destinationLat: (destination['lat'] as num).toDouble(),
          destinationLng: (destination['lng'] as num).toDouble(),
        );

        if (distance <= radiusKm) {
          destination['id'] = doc.id;
          destination['distance'] = distance;
          nearbyDestinations.add(destination);
        }
      }

      // Sort by distance ascending
      nearbyDestinations.sort(
        (a, b) => (a['distance'] as num).compareTo((b['distance'] as num)),
      );

      return nearbyDestinations.take(limit).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan destinasi terdekat: $e');
    }
  }

  // Get recommendations based on visit history
  Future<List<Map<String, dynamic>>> getHistoryBasedRecommendations({
    required String userId,
    required double userLat,
    required double userLng,
    int limit = 5,
  }) async {
    try {
      // Get user's booking history
      final bookingsSnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      // Extract categories from visited destinations
      Set<String> visitedCategories = {};
      for (var booking in bookingsSnapshot.docs) {
        final destinationId = booking.data()['destinationId'];
        final destSnapshot = await _firestore
            .collection('destinations')
            .doc(destinationId)
            .get();

        if (destSnapshot.exists) {
          final category = destSnapshot.data()?['kategori'];
          if (category != null) {
            visitedCategories.add(category);
          }
        }
      }

      // Get destinations with similar categories
      final destinationsSnapshot = await _firestore
          .collection('destinations')
          .get();

      List<Map<String, dynamic>> recommendations = [];

      for (var doc in destinationsSnapshot.docs) {
        final destination = doc.data();

        // Skip already visited destinations
        if (bookingsSnapshot.docs.any(
          (b) => b.data()['destinationId'] == doc.id,
        )) {
          continue;
        }

        // Score based on category similarity
        if (visitedCategories.contains(destination['kategori'])) {
          final distance = _locationService.calculateDistance(
            userLat: userLat,
            userLng: userLng,
            destinationLat: (destination['lat'] as num).toDouble(),
            destinationLng: (destination['lng'] as num).toDouble(),
          );

          destination['id'] = doc.id;
          destination['distance'] = distance;
          recommendations.add(destination);
        }
      }

      // Sort by rating
      recommendations.sort(
        (a, b) => (b['rating'] as num).compareTo((a['rating'] as num)),
      );

      return recommendations.take(limit).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan rekomendasi history: $e');
    }
  }

  // Get trending destinations (most booked recently)
  Future<List<Map<String, dynamic>>> getTrendingDestinations({
    int limit = 10,
    int daysBack = 30,
  }) async {
    try {
      final dateThreshold = DateTime.now().subtract(Duration(days: daysBack));

      // Get recent bookings
      final bookingsSnapshot = await _firestore
          .collection('bookings')
          .where('createdAt', isGreaterThan: Timestamp.fromDate(dateThreshold))
          .get();

      // Count bookings per destination
      Map<String, int> destinationBookingCount = {};
      for (var booking in bookingsSnapshot.docs) {
        final destId = booking.data()['destinationId'];
        destinationBookingCount[destId] =
            (destinationBookingCount[destId] ?? 0) + 1;
      }

      // Get destination details
      List<Map<String, dynamic>> trendingDestinations = [];
      for (var entry in destinationBookingCount.entries) {
        final destSnapshot = await _firestore
            .collection('destinations')
            .doc(entry.key)
            .get();

        if (destSnapshot.exists) {
          final data = destSnapshot.data()!;
          data['id'] = destSnapshot.id;
          data['bookingCount'] = entry.value;
          trendingDestinations.add(data);
        }
      }

      // Sort by booking count
      trendingDestinations.sort(
        (a, b) =>
            (b['bookingCount'] as int).compareTo((a['bookingCount'] as int)),
      );

      return trendingDestinations.take(limit).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan destinasi trending: $e');
    }
  }
}
