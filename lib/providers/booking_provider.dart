import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/booking_model.dart';
import '../services/payment_service.dart';

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PaymentService _paymentService = PaymentService();
  static const _uuid = Uuid();

  List<BookingModel> _bookings = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get bookingCount => _bookings.length;

  // Load user bookings
  Future<void> loadBookings({required String userId}) async {
    _setLoading(true);
    _clearError();

    try {
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _bookings = snapshot.docs
          .map((doc) =>
              BookingModel.fromJson(doc.id, doc.data()))
          .toList();

      _setLoading(false);
    } catch (e) {
      _setError('Gagal memuat booking: $e');
      _setLoading(false);
      rethrow;
    }
  }

  // Create booking
  Future<BookingModel> createBooking({
    required String userId,
    required String destinationId,
    required String destinationName,
    required DateTime visitDate,
    required int quantity,
    required double pricePerTicket,
  }) async {
    _clearError();

    try {
      final bookingId = _uuid.v4();
      final totalPrice = quantity * pricePerTicket;
      final now = DateTime.now();

      final booking = BookingModel(
        bookingId: bookingId,
        userId: userId,
        destinationId: destinationId,
        destinationName: destinationName,
        visitDate: visitDate,
        quantity: quantity,
        pricePerTicket: pricePerTicket,
        totalPrice: totalPrice,
        paymentStatus: 'pending',
        bookingStatus: 'pending',
        qrCode: _generateQRCode(bookingId),
        createdAt: now,
      );

      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .set(booking.toJson());

      _bookings.insert(0, booking);
      notifyListeners();

      return booking;
    } catch (e) {
      _setError('Gagal membuat booking: $e');
      rethrow;
    }
  }

  // Process payment for booking
  Future<void> processBookingPayment({
    required String bookingId,
    required PaymentMethod method,
  }) async {
    _clearError();

    try {
      final booking = _bookings.firstWhere(
        (b) => b.bookingId == bookingId,
        orElse: () => throw Exception('Booking tidak ditemukan'),
      );

      // Create payment
      final payment = await _paymentService.createPayment(
        bookingId: bookingId,
        userId: booking.userId,
        amount: booking.totalPrice,
        method: method,
      );

      // Process payment
      final result = await _paymentService.processPayment(
        paymentId: payment['paymentId'],
        method: method,
      );

      // Update booking
      if (result['status'] == 'success') {
        final index = _bookings.indexWhere((b) => b.bookingId == bookingId);
        _bookings[index] = booking.copyWith(
          paymentStatus: 'paid',
          bookingStatus: 'confirmed',
          paymentId: payment['paymentId'],
          updatedAt: DateTime.now(),
        );

        await _firestore
            .collection('bookings')
            .doc(bookingId)
            .update(_bookings[index].toJson());
      } else {
        throw Exception('Pembayaran gagal: ${result['status']}');
      }

      notifyListeners();
    } catch (e) {
      _setError('Gagal memproses pembayaran: $e');
      rethrow;
    }
  }

  // Cancel booking
  Future<void> cancelBooking({required String bookingId}) async {
    _clearError();

    try {
      final booking = _bookings.firstWhere(
        (b) => b.bookingId == bookingId,
        orElse: () => throw Exception('Booking tidak ditemukan'),
      );

      // Only allow cancellation if booking is pending or confirmed
      if (booking.bookingStatus == 'used' ||
          booking.bookingStatus == 'expired') {
        throw Exception(
            'Booking ${booking.bookingStatus} tidak bisa dibatalkan');
      }

      // If paid, process refund (simplified)
      if (booking.paymentStatus == 'paid' && booking.paymentId != null) {
        await _paymentService.cancelPayment(
            paymentId: booking.paymentId!);
      }

      final index = _bookings.indexWhere((b) => b.bookingId == bookingId);
      _bookings[index] = booking.copyWith(
        bookingStatus: 'cancelled',
        paymentStatus: 'cancelled',
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .update(_bookings[index].toJson());

      notifyListeners();
    } catch (e) {
      _setError('Gagal membatalkan booking: $e');
      rethrow;
    }
  }

  // Mark booking as used
  Future<void> markBookingAsUsed({required String bookingId}) async {
    _clearError();

    try {
      final booking = _bookings.firstWhere(
        (b) => b.bookingId == bookingId,
        orElse: () => throw Exception('Booking tidak ditemukan'),
      );

      if (booking.bookingStatus == 'used') {
        throw Exception('Booking sudah digunakan');
      }

      if (booking.paymentStatus != 'paid') {
        throw Exception('Booking belum dibayar');
      }

      final index = _bookings.indexWhere((b) => b.bookingId == bookingId);
      final now = DateTime.now();
      _bookings[index] = booking.copyWith(
        bookingStatus: 'used',
        updatedAt: now,
        usedAt: now,
      );

      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .update(_bookings[index].toJson());

      notifyListeners();
    } catch (e) {
      _setError('Gagal menandai booking sebagai used: $e');
      rethrow;
    }
  }

  // Get bookings by status
  List<BookingModel> getBookingsByStatus(String status) {
    return _bookings
        .where((booking) => booking.bookingStatus == status)
        .toList();
  }

  // Get active bookings
  List<BookingModel> getActiveBookings() {
    return _bookings
        .where((booking) =>
            booking.bookingStatus != 'cancelled' &&
            booking.bookingStatus != 'expired')
        .toList();
  }

  // Get upcoming bookings
  List<BookingModel> getUpcomingBookings() {
    return _bookings
        .where((booking) => booking.visitDate.isAfter(DateTime.now()))
        .toList();
  }

  // Get past bookings
  List<BookingModel> getPastBookings() {
    return _bookings
        .where((booking) => booking.visitDate.isBefore(DateTime.now()))
        .toList();
  }

  // Get booking by ID
  BookingModel? getBookingById(String bookingId) {
    try {
      return _bookings.firstWhere((b) => b.bookingId == bookingId);
    } catch (e) {
      return null;
    }
  }

  // Get total spent
  Future<double> getTotalSpent({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .where('paymentStatus', isEqualTo: 'paid')
          .get();

      double total = 0;
      for (var doc in snapshot.docs) {
        total += (doc.data()['totalPrice'] as num).toDouble();
      }

      return total;
    } catch (e) {
      _setError('Gagal menghitung total spending: $e');
      return 0;
    }
  }

  // Get booking statistics
  Future<Map<String, dynamic>> getBookingStatistics({
    required String userId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      int totalBookings = snapshot.size;
      int confirmedBookings = 0;
      int usedBookings = 0;
      int cancelledBookings = 0;
      double totalSpent = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        totalSpent += (data['totalPrice'] as num).toDouble();

        switch (data['bookingStatus']) {
          case 'confirmed':
            confirmedBookings++;
            break;
          case 'used':
            usedBookings++;
            break;
          case 'cancelled':
            cancelledBookings++;
            break;
        }
      }

      return {
        'totalBookings': totalBookings,
        'confirmedBookings': confirmedBookings,
        'usedBookings': usedBookings,
        'cancelledBookings': cancelledBookings,
        'totalSpent': totalSpent,
      };
    } catch (e) {
      _setError('Gagal mendapatkan statistik booking: $e');
      return {};
    }
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

  String _generateQRCode(String bookingId) {
    return 'GISTOUR_$bookingId';
  }
}
