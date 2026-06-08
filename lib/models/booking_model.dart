import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String userId;
  final String destinationId;
  final String destinationName;
  final DateTime visitDate;
  final int quantity;
  final double pricePerTicket;
  final double totalPrice;
  final String paymentStatus; // pending, paid, cancelled
  final String bookingStatus; // confirmed, expired, used, cancelled
  final String? qrCode;
  final String? paymentId;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? usedAt;

  const BookingModel({
    required this.bookingId,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    required this.visitDate,
    required this.quantity,
    required this.pricePerTicket,
    required this.totalPrice,
    required this.paymentStatus,
    required this.bookingStatus,
    this.qrCode,
    this.paymentId,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.usedAt,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'userId': userId,
      'destinationId': destinationId,
      'destinationName': destinationName,
      'visitDate': Timestamp.fromDate(visitDate),
      'quantity': quantity,
      'pricePerTicket': pricePerTicket,
      'totalPrice': totalPrice,
      'paymentStatus': paymentStatus,
      'bookingStatus': bookingStatus,
      'qrCode': qrCode,
      'paymentId': paymentId,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'usedAt': usedAt != null ? Timestamp.fromDate(usedAt!) : null,
    };
  }

  // Create from JSON
  factory BookingModel.fromJson(
      String docId, Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] as String,
      userId: json['userId'] as String,
      destinationId: json['destinationId'] as String,
      destinationName: json['destinationName'] as String,
      visitDate: (json['visitDate'] as Timestamp).toDate(),
      quantity: json['quantity'] as int,
      pricePerTicket: (json['pricePerTicket'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      bookingStatus: json['bookingStatus'] as String,
      qrCode: json['qrCode'] as String?,
      paymentId: json['paymentId'] as String?,
      notes: json['notes'] as String?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      usedAt: json['usedAt'] != null
          ? (json['usedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Copy with
  BookingModel copyWith({
    String? bookingId,
    String? userId,
    String? destinationId,
    String? destinationName,
    DateTime? visitDate,
    int? quantity,
    double? pricePerTicket,
    double? totalPrice,
    String? paymentStatus,
    String? bookingStatus,
    String? qrCode,
    String? paymentId,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? usedAt,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      userId: userId ?? this.userId,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      visitDate: visitDate ?? this.visitDate,
      quantity: quantity ?? this.quantity,
      pricePerTicket: pricePerTicket ?? this.pricePerTicket,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      qrCode: qrCode ?? this.qrCode,
      paymentId: paymentId ?? this.paymentId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usedAt: usedAt ?? this.usedAt,
    );
  }

  // Check if booking is still valid
  bool isValid() {
    return bookingStatus != 'cancelled' &&
        bookingStatus != 'expired' &&
        visitDate.isAfter(DateTime.now());
  }

  // Check if booking can be used today
  bool canBeUsedToday() {
    final today = DateTime.now();
    return visitDate.year == today.year &&
        visitDate.month == today.month &&
        visitDate.day == today.day;
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingModel && other.bookingId == bookingId;
  }

  @override
  int get hashCode => bookingId.hashCode;

  @override
  String toString() {
    return 'BookingModel(bookingId: $bookingId, userId: $userId, '
        'destinationName: $destinationName, visitDate: $visitDate, '
        'paymentStatus: $paymentStatus)';
  }
}
