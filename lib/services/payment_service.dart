import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum PaymentMethod { qris, eWallet, bankTransfer }

enum PaymentStatus { pending, processing, success, failed, cancelled }

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const _uuid = Uuid();

  // Create payment
  Future<Map<String, dynamic>> createPayment({
    required String bookingId,
    required String userId,
    required double amount,
    required PaymentMethod method,
  }) async {
    try {
      final paymentId = _uuid.v4();
      final now = DateTime.now();

      final paymentData = {
        'paymentId': paymentId,
        'bookingId': bookingId,
        'userId': userId,
        'amount': amount,
        'method': method.toString().split('.').last,
        'status': PaymentStatus.pending.toString().split('.').last,
        'qrCode': _generateQRCode(paymentId),
        'referenceNumber': _generateReferenceNumber(),
        'expiryTime': now.add(const Duration(minutes: 15)),
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      await _firestore
          .collection('payments')
          .doc(paymentId)
          .set(paymentData);

      return paymentData;
    } catch (e) {
      throw Exception('Gagal membuat pembayaran: $e');
    }
  }

  // Check payment status
  Future<Map<String, dynamic>> checkPaymentStatus({
    required String paymentId,
  }) async {
    try {
      final doc = await _firestore
          .collection('payments')
          .doc(paymentId)
          .get();

      if (!doc.exists) {
        throw Exception('Pembayaran tidak ditemukan');
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return data;
    } catch (e) {
      throw Exception('Gagal mengecek status pembayaran: $e');
    }
  }

  // Process payment (simulate)
  Future<Map<String, dynamic>> processPayment({
    required String paymentId,
    required PaymentMethod method,
  }) async {
    try {
      // Simulate payment processing delay
      await Future.delayed(const Duration(seconds: 2));

      // Randomly determine success (90% success rate)
      final isSuccess = DateTime.now().millisecond % 10 != 9;

      final status = isSuccess
          ? PaymentStatus.success.toString().split('.').last
          : PaymentStatus.failed.toString().split('.').last;

      await _firestore
          .collection('payments')
          .doc(paymentId)
          .update({
        'status': status,
        'updatedAt': Timestamp.now(),
        'processedAt': Timestamp.now(),
      });

      // If payment successful, update booking status
      if (isSuccess) {
        final payment = await checkPaymentStatus(paymentId: paymentId);
        await _firestore
            .collection('bookings')
            .doc(payment['bookingId'])
            .update({
          'paymentStatus': 'paid',
          'updatedAt': Timestamp.now(),
        });
      }

      return await checkPaymentStatus(paymentId: paymentId);
    } catch (e) {
      throw Exception('Gagal memproses pembayaran: $e');
    }
  }

  // Cancel payment
  Future<void> cancelPayment({required String paymentId}) async {
    try {
      final payment = await checkPaymentStatus(paymentId: paymentId);

      // Only allow cancellation if payment is still pending
      if (payment['status'] != 'pending') {
        throw Exception(
            'Hanya pembayaran dengan status pending yang bisa dibatalkan');
      }

      await _firestore
          .collection('payments')
          .doc(paymentId)
          .update({
        'status': PaymentStatus.cancelled.toString().split('.').last,
        'updatedAt': Timestamp.now(),
        'cancelledAt': Timestamp.now(),
      });

      // Update booking status
      await _firestore
          .collection('bookings')
          .doc(payment['bookingId'])
          .update({
        'paymentStatus': 'cancelled',
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Gagal membatalkan pembayaran: $e');
    }
  }

  // Get payment history
  Future<List<Map<String, dynamic>>> getPaymentHistory({
    required String userId,
    int limit = 20,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('payments')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Gagal mendapatkan riwayat pembayaran: $e');
    }
  }

  // Get total spent
  Future<double> getTotalSpent({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection('payments')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'success')
          .get();

      double total = 0;
      for (var doc in snapshot.docs) {
        total += (doc.data()['amount'] as num).toDouble();
      }

      return total;
    } catch (e) {
      throw Exception('Gagal menghitung total spending: $e');
    }
  }

  // Verify QR code
  Future<Map<String, dynamic>> verifyQRCode({
    required String qrCodeData,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('payments')
          .where('qrCode', isEqualTo: qrCodeData)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('QR code tidak valid');
      }

      return snapshot.docs.first.data();
    } catch (e) {
      throw Exception('Gagal verifikasi QR code: $e');
    }
  }

  // Validate payment amount
  bool validatePaymentAmount(double amount) {
    return amount > 0 && amount <= 999999999.99;
  }

  // Get payment methods
  List<Map<String, dynamic>> getPaymentMethods() {
    return [
      {
        'id': PaymentMethod.qris.toString().split('.').last,
        'name': 'QRIS',
        'icon': '📱',
        'description': 'Scan dengan aplikasi perbankan Anda',
      },
      {
        'id': PaymentMethod.eWallet.toString().split('.').last,
        'name': 'E-Wallet',
        'icon': '💳',
        'description': 'GoPay, OVO, Dana, LinkAja, dll',
      },
      {
        'id': PaymentMethod.bankTransfer.toString().split('.').last,
        'name': 'Transfer Bank',
        'icon': '🏦',
        'description': 'Transfer ke rekening GisTour',
      },
    ];
  }

  // Generate bank account details (simulated)
  Map<String, String> getBankAccountDetails() {
    return {
      'bankName': 'Bank Rakyat Indonesia (BRI)',
      'accountNumber': '0123-4567-8910-1112',
      'accountHolder': 'PT GisTour Wisata',
      'swiftCode': 'BRINIDJA',
    };
  }

  // Generate QR code (simulated - actual QR generation needed)
  String _generateQRCode(String paymentId) {
    return 'QR_$paymentId';
  }

  // Generate reference number
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'GISTOUR${timestamp.substring(timestamp.length - 10)}';
  }

  // Format payment method name
  String formatPaymentMethodName(String method) {
    switch (method) {
      case 'qris':
        return 'QRIS';
      case 'eWallet':
        return 'E-Wallet';
      case 'bankTransfer':
        return 'Transfer Bank';
      default:
        return method;
    }
  }

  // Format currency
  String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  }
}
