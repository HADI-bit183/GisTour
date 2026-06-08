import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String id;
  final String userId;
  final String destinationId;
  final String destinationName;
  final String? imageUrl;
  final double? rating;
  final String? kategori;
  final DateTime createdAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    this.imageUrl,
    this.rating,
    this.kategori,
    required this.createdAt,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'destinationId': destinationId,
      'destinationName': destinationName,
      'imageUrl': imageUrl,
      'rating': rating,
      'kategori': kategori,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create from JSON
  factory FavoriteModel.fromJson(
      String docId, Map<String, dynamic> json) {
    return FavoriteModel(
      id: docId,
      userId: json['userId'] as String,
      destinationId: json['destinationId'] as String,
      destinationName: json['destinationName'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      kategori: json['kategori'] as String?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  // Copy with
  FavoriteModel copyWith({
    String? id,
    String? userId,
    String? destinationId,
    String? destinationName,
    String? imageUrl,
    double? rating,
    String? kategori,
    DateTime? createdAt,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      kategori: kategori ?? this.kategori,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteModel &&
        other.userId == userId &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode => userId.hashCode ^ destinationId.hashCode;

  @override
  String toString() {
    return 'FavoriteModel(userId: $userId, destinationId: $destinationId, '
        'destinationName: $destinationName, createdAt: $createdAt)';
  }
}
