import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<FavoriteModel> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  final Set<String> _togglingIds = {};
  String? _loadedUserId;

  List<FavoriteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get favoriteCount => _favorites.length;

  Future<void> loadFavorites({required String userId}) async {
    // Jika userId sama dan tidak sedang loading, skip
    if (_loadedUserId == userId && !_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _favorites = snapshot.docs
          .map((doc) => FavoriteModel.fromJson(doc.id, doc.data()))
          .toList();

      _loadedUserId = userId;
    } catch (e) {
      _errorMessage = 'Gagal memuat favorit: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // satu kali notify di akhir
    }
  }

  Future<void> addFavorite({
    required String userId,
    required String destinationId,
    required String destinationName,
    String? imageUrl,
    double? rating,
    String? kategori,
  }) async {
    _errorMessage = null;

    // Sudah ada di list lokal, tidak perlu tambah lagi
    if (_favorites.any((f) => f.destinationId == destinationId)) return;

    try {
      // Cek di Firestore kalau-kalau sudah ada tapi belum di list lokal
      final existing = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .where('destinationId', isEqualTo: destinationId)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        // Sudah ada di Firestore, sync ke list lokal saja
        final model = FavoriteModel.fromJson(
          existing.docs.first.id,
          existing.docs.first.data(),
        );
        _favorites.insert(0, model);
        notifyListeners();
        return;
      }

      // Belum ada, buat baru
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

      // Update list lokal DULU agar UI langsung reaktif
      _favorites.insert(0, favorite);
      notifyListeners();

      // Baru simpan ke Firestore
      await docRef.set(favorite.toJson());
    } catch (e) {
      // Rollback list lokal jika Firestore gagal
      _favorites.removeWhere((f) => f.destinationId == destinationId);
      _errorMessage = 'Gagal menambah favorit: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeFavorite({required String destinationId}) async {
    _errorMessage = null;

    // Cari di list lokal
    final index = _favorites.indexWhere(
      (f) => f.destinationId == destinationId,
    );
    FavoriteModel? removed;

    if (index != -1) {
      removed = _favorites[index];
      // Hapus dari list lokal DULU agar UI langsung reaktif
      _favorites.removeAt(index);
      notifyListeners();
    }

    try {
      if (removed != null) {
        // Hapus dari Firestore pakai doc ID
        await _firestore.collection('favorites').doc(removed.id).delete();
      } else {
        // Fallback: cari di Firestore
        final snapshot = await _firestore
            .collection('favorites')
            .where('destinationId', isEqualTo: destinationId)
            .limit(1)
            .get();
        if (snapshot.docs.isNotEmpty) {
          await snapshot.docs.first.reference.delete();
        }
      }
    } catch (e) {
      // Rollback: kembalikan item ke list lokal jika Firestore gagal
      if (removed != null) {
        _favorites.insert(index == -1 ? 0 : index, removed);
        notifyListeners();
      }
      _errorMessage = 'Gagal menghapus favorit: $e';
      rethrow;
    }
  }

  Future<List<FavoriteModel>> getFavorites({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => FavoriteModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      _errorMessage = 'Gagal mendapatkan favorit: $e';
      rethrow;
    }
  }

  bool isFavorite(String destinationId) {
    return _favorites.any((fav) => fav.destinationId == destinationId);
  }

  Future<void> toggleFavorite({
    required String userId,
    required String destinationId,
    required String destinationName,
    String? imageUrl,
    double? rating,
    String? kategori,
  }) async {
    if (_togglingIds.contains(destinationId)) return;

    _togglingIds.add(destinationId);
    try {
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
    } finally {
      _togglingIds.remove(destinationId);
    }
  }

  FavoriteModel? getFavoriteByDestinationId(String destinationId) {
    try {
      return _favorites.firstWhere((fav) => fav.destinationId == destinationId);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearAllFavorites({required String userId}) async {
    _errorMessage = null;

    final backup = List<FavoriteModel>.from(_favorites);
    _favorites.clear();
    notifyListeners();

    try {
      final batch = _firestore.batch();
      for (var favorite in backup) {
        batch.delete(_firestore.collection('favorites').doc(favorite.id));
      }
      await batch.commit();
    } catch (e) {
      _favorites.addAll(backup);
      notifyListeners();
      _errorMessage = 'Gagal menghapus semua favorit: $e';
      rethrow;
    }
  }

  List<FavoriteModel> getFavoritesByCategory(String category) {
    return _favorites.where((fav) => fav.kategori == category).toList();
  }

  List<FavoriteModel> getFavoritesSortedByRating() {
    final sorted = List<FavoriteModel>.from(_favorites);
    sorted.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    return sorted;
  }

  List<FavoriteModel> searchFavorites(String query) {
    return _favorites
        .where(
          (fav) =>
              fav.destinationName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
