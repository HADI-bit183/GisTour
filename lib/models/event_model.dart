import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime eventDate;
  final DateTime? eventEndDate;
  final String location;
  final String? locationDetails;
  final double ticketPrice;
  final int? ticketLimit;
  final int ticketsSold;
  final String? organizerName;
  final String? organizerPhone;
  final List<String> tags;
  final double? rating;
  final int? reviewCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.eventDate,
    this.eventEndDate,
    required this.location,
    this.locationDetails,
    required this.ticketPrice,
    this.ticketLimit,
    this.ticketsSold = 0,
    this.organizerName,
    this.organizerPhone,
    this.tags = const [],
    this.rating,
    this.reviewCount,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'eventDate': Timestamp.fromDate(eventDate),
      'eventEndDate':
          eventEndDate != null ? Timestamp.fromDate(eventEndDate!) : null,
      'location': location,
      'locationDetails': locationDetails,
      'ticketPrice': ticketPrice,
      'ticketLimit': ticketLimit,
      'ticketsSold': ticketsSold,
      'organizerName': organizerName,
      'organizerPhone': organizerPhone,
      'tags': tags,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isActive': isActive,
    };
  }

  // Create from JSON
  factory EventModel.fromJson(String docId, Map<String, dynamic> json) {
    return EventModel(
      id: docId,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      eventDate: (json['eventDate'] as Timestamp).toDate(),
      eventEndDate: json['eventEndDate'] != null
          ? (json['eventEndDate'] as Timestamp).toDate()
          : null,
      location: json['location'] as String,
      locationDetails: json['locationDetails'] as String?,
      ticketPrice: (json['ticketPrice'] as num).toDouble(),
      ticketLimit: json['ticketLimit'] as int?,
      ticketsSold: json['ticketsSold'] as int? ?? 0,
      organizerName: json['organizerName'] as String?,
      organizerPhone: json['organizerPhone'] as String?,
      tags: List<String>.from(json['tags'] as List? ?? []),
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      reviewCount: json['reviewCount'] as int?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  // Copy with
  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    DateTime? eventDate,
    DateTime? eventEndDate,
    String? location,
    String? locationDetails,
    double? ticketPrice,
    int? ticketLimit,
    int? ticketsSold,
    String? organizerName,
    String? organizerPhone,
    List<String>? tags,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      eventDate: eventDate ?? this.eventDate,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      location: location ?? this.location,
      locationDetails: locationDetails ?? this.locationDetails,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketLimit: ticketLimit ?? this.ticketLimit,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      organizerName: organizerName ?? this.organizerName,
      organizerPhone: organizerPhone ?? this.organizerPhone,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  // Check if event is upcoming
  bool isUpcoming() {
    return eventDate.isAfter(DateTime.now()) && isActive;
  }

  // Check if event is today
  bool isToday() {
    final now = DateTime.now();
    return eventDate.year == now.year &&
        eventDate.month == now.month &&
        eventDate.day == now.day;
  }

  // Check if event is passed
  bool isPassed() {
    return eventDate.isBefore(DateTime.now());
  }

  // Check if tickets available
  bool hasTicketsAvailable() {
    if (ticketLimit == null) return true;
    return ticketsSold < ticketLimit!;
  }

  // Get remaining tickets
  int? getRemainingTickets() {
    if (ticketLimit == null) return null;
    return ticketLimit! - ticketsSold;
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, eventDate: $eventDate, '
        'location: $location, ticketPrice: $ticketPrice)';
  }
}
