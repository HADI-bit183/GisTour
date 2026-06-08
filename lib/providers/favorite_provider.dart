import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<FavoriteModel> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<FavoriteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get favoriteCount => _favorites.length;

  // Load user favorites
  Future<void> loadFavorites({required String userId}) async {
    _setLoading(true);
    _clearError();

    try {
      final snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _favorites = snapshot.docs
          .map((doc) =>
              FavoriteModel.fromJson(doc.id, doc.data()))
          .toList();

      _setLoading(false);
    } catch (e) {
      _setError('Gagal memuat favorit: $e');
      _setLoading(false);
      rethrow;
    }
  }

  // Add to favorites
  Future<void> addFavorite({
    required String userId,
    required String destinationId,
    required String destinationName,
    String? imageUrl,
    double? rating,
    String? kategori,
  }) async {
    _clearError();

    try {
      // Check if already favorited
      if (isFavorite(destinationId)) {
        throw Exception('Sudah ditambahkan ke favorit');
      }

      final docRef = _firestore.collection('favorites').doc();
      final favorite = FavoriteModel(
        id: docRef.id,
        userId: userId,
        destinationId: destinationId,
        destinationName: destinationName,
        imageUrl: imageUrl,
        rating: rating,
        kategori: kategori,
        createdAt: DateTime.now(),
      );

      await docRef.set(favorite.toJson());
      _favorites.insert(0, favorite);
      notifyListeners();
    } catch (e) {
      _setError('Gagal menambah favorit: $e');
      rethrow;
    }
  }

  // Remove from favorites
  Future<void> removeFavorite({required String destinationId}) async {
    _clearError();

    try {
      final favorite = _favorites.firstWhere(
        (fav) => fav.destinationId == destinationId,
        orElse: () => throw Exception('Favorit tidak ditemukan'),
      );

      await _firestore
          .collection('favorites')
          .doc(favorite.id)
          .delete();

      _favorites.removeWhere((fav) => fav.destinationId == destinationId);
      notifyListeners();
    } catch (e) {
      _setError('Gagal menghapus favorit: $e');
      rethrow;
    }
  }

  // Get favorites
  Future<List<FavoriteModel>> getFavorites({
    required String userId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) =>
              FavoriteModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      _setError('Gagal mendapatkan favorit: $e');
      rethrow;
    }
  }

  // Check if destination is favorited
  bool isFavorite(String destinationId) {
    return _favorites.any((fav) => fav.destinationId == destinationId);
  }

  // Toggle favorite
  Future<void> toggleFavorite({
    required String userId,
    required String destinationId,
    required String destinationName,
    String? imageUrl,
    double? rating,
    String? kategori,
  }) async {
    if (isFavorite(destinationId)) {
      await removeFavorite(destinationId: destinationId);
    } else {
      await addFavorite(
        userId: userId,
        destinationId: destinationId,
        destinationName: destinationName,
        imageUrl: imageUrl,
        rating: rating,
        kategori: kategori,
      );
    }
  }

  // Get favorite by destination ID
  FavoriteModel? getFavoriteByDestinationId(String destinationId) {
    try {
      return _favorites.firstWhere(
        (fav) => fav.destinationId == destinationId,
      );
    } catch (e) {
      return null;
    }
  }

  // Clear all favorites
  Future<void> clearAllFavorites({required String userId}) async {
    _clearError();

    try {
      final batch = _firestore.batch();

      for (var favorite in _favorites) {
        batch.delete(_firestore
            .collection('favorites')
            .doc(favorite.id));
      }

      await batch.commit();
      _favorites.clear();
      notifyListeners();
    } catch (e) {
      _setError('Gagal menghapus semua favorit: $e');
      rethrow;
    }
  }

  // Get favorites by category
  List<FavoriteModel> getFavoritesByCategory(String category) {
    return _favorites
        .where((fav) => fav.kategori == category)
        .toList();
  }

  // Get favorites sorted by rating
  List<FavoriteModel> getFavoritesSortedByRating() {
    final sorted = List<FavoriteModel>.from(_favorites);
    sorted.sort((a, b) => (b.rating ?? 0)
        .compareTo((a.rating ?? 0)));
    return sorted;
  }

  // Search favorites
  List<FavoriteModel> searchFavorites(String query) {
    return _favorites
        .where((fav) => fav.destinationName
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
