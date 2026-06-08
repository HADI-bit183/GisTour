import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String destinationId;
  final double rating;
  final String comment;
  final List<String> imageUrls;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int helpfulCount;
  final List<String> helpfulUsers;

  const ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.destinationId,
    required this.rating,
    required this.comment,
    this.imageUrls = const [],
    required this.createdAt,
    this.updatedAt,
    this.helpfulCount = 0,
    this.helpfulUsers = const [],
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'destinationId': destinationId,
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'helpfulCount': helpfulCount,
      'helpfulUsers': helpfulUsers,
    };
  }

  // Create from JSON
  factory ReviewModel.fromJson(
      String docId, Map<String, dynamic> json) {
    return ReviewModel(
      id: docId,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      destinationId: json['destinationId'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      helpfulCount: json['helpfulCount'] as int? ?? 0,
      helpfulUsers:
          List<String>.from(json['helpfulUsers'] as List? ?? []),
    );
  }

  // Copy with
  ReviewModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    String? destinationId,
    double? rating,
    String? comment,
    List<String>? imageUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? helpfulCount,
    List<String>? helpfulUsers,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      destinationId: destinationId ?? this.destinationId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      helpfulUsers: helpfulUsers ?? this.helpfulUsers,
    );
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.id == id &&
        other.userId == userId &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ destinationId.hashCode;

  @override
  String toString() {
    return 'ReviewModel(id: $id, userId: $userId, rating: $rating, '
        'destinationId: $destinationId)';
  }
}
