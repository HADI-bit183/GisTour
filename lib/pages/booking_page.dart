import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import '../services/payment_service.dart';

const _navy = Color(0xFF0B1F3A);
const _navyDark = Color(0xFF0D2B55);
const _blue = Color(0xFF1565C0);
const _bodyBg = Color(0xFFF0F4FC);

class BookingPage extends StatefulWidget {
  final String destinationId;
  final String destinationName;
  final double ticketPrice;

  const BookingPage({
    super.key,
    required this.destinationId,
    required this.destinationName,
    required this.ticketPrice,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late DateTime _selectedDate;
  int _quantity = 1;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.qris;

  // ── FIX: pakai dua flag terpisah ─────────────────────────────
  bool _isCreatingBooking = false; // fase 1: simpan booking
  bool _isProcessingPayment = false; // fase 2: proses pembayaran
  bool get _isProcessing => _isCreatingBooking || _isProcessingPayment;

  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    initializeDateFormatting('id_ID').then((_) {
      if (mounted) setState(() {});
    });
    _dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
  }

  String _formatDate(DateTime date) {
    try {
      return _dateFormat.format(date);
    } catch (_) {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  double get _totalPrice => widget.ticketPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBg,
      appBar: AppBar(
        backgroundColor: _navyDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Pesan Tiket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDestinationInfo(),
                const SizedBox(height: 14),
                _buildDateSelection(),
                const SizedBox(height: 14),
                _buildQuantitySelection(),
                const SizedBox(height: 14),
                _buildPriceBreakdown(),
                const SizedBox(height: 14),
                _buildPaymentMethodSelection(),
              ],
            ),
          ),

          // ── Tombol Bayar di bawah (fixed) ──────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: _bodyBg,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
              child: _buildBookingButton(),
            ),
          ),

          // ── FIX: Loading overlay ─────────────────────────────
          if (_isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.35),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(_navyDark),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isCreatingBooking
                            ? 'Membuat pesanan...'
                            : 'Memproses pembayaran...',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _navy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Info Destinasi ────────────────────────────────────────────
  Widget _buildDestinationInfo() {
    return _card(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.place_rounded, color: _blue, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.destinationName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _navy,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Harga per tiket: ',
                      style: TextStyle(fontSize: 12, color: Color(0xFF99AABB)),
                    ),
                    Text(
                      _formatPrice(widget.ticketPrice),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Pilih Tanggal ─────────────────────────────────────────────
  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Tanggal Kunjung'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _isProcessing
              ? null
              : () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: _navyDark,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
          child: _card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: _blue,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _formatDate(_selectedDate),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _navy,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF99AABB),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Jumlah Tiket ──────────────────────────────────────────────
  Widget _buildQuantitySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Jumlah Tiket'),
        const SizedBox(height: 8),
        _card(
          child: Row(
            children: [
              _qtyButton(
                icon: Icons.remove_rounded,
                onTap: (!_isProcessing && _quantity > 1)
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _navy,
                      ),
                    ),
                    const Text(
                      'tiket',
                      style: TextStyle(fontSize: 11, color: Color(0xFF99AABB)),
                    ),
                  ],
                ),
              ),
              _qtyButton(
                icon: Icons.add_rounded,
                onTap: (!_isProcessing && _quantity < 10)
                    ? () => setState(() => _quantity++)
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _qtyButton({required IconData icon, VoidCallback? onTap}) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? _navyDark : const Color(0xFFEEF2F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : const Color(0xFFCDD6E0),
          size: 20,
        ),
      ),
    );
  }

  // ── Rincian Harga ─────────────────────────────────────────────
  Widget _buildPriceBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Rincian Harga'),
        const SizedBox(height: 8),
        _card(
          child: Column(
            children: [
              _priceRow('Harga satuan', _formatPrice(widget.ticketPrice)),
              const SizedBox(height: 6),
              _priceRow('Jumlah tiket', '$_quantity tiket'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: Color(0xFFEEF2F8), height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _navy,
                    ),
                  ),
                  Text(
                    _formatPrice(_totalPrice),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: _navy,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ── Metode Pembayaran ─────────────────────────────────────────
  Widget _buildPaymentMethodSelection() {
    final methods = PaymentService().getPaymentMethods();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Metode Pembayaran'),
        const SizedBox(height: 8),
        _card(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(methods.length, (i) {
              final method = methods[i];
              final selected =
                  _selectedPaymentMethod == PaymentMethod.values[i];
              return GestureDetector(
                onTap: _isProcessing
                    ? null
                    : () => setState(
                        () => _selectedPaymentMethod = PaymentMethod.values[i],
                      ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? _navyDark.withValues(alpha: 0.05)
                        : Colors.transparent,
                    border: i < methods.length - 1
                        ? const Border(
                            bottom: BorderSide(color: Color(0xFFEEF2F8)),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(
                        method['icon'],
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['name'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: selected ? _navyDark : _navy,
                              ),
                            ),
                            Text(
                              method['description'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF99AABB),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? _navyDark
                                : const Color(0xFFDDEAF5),
                            width: 2,
                          ),
                          color: selected ? _navyDark : Colors.transparent,
                        ),
                        child: selected
                            ? const Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── Tombol Booking ────────────────────────────────────────────
  Widget _buildBookingButton() {
    final authProvider = Provider.of<AuthProvider>(context);
    final enabled = !_isProcessing && authProvider.isLoggedIn;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? _handleBooking : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _navyDark,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFDDE4F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.confirmation_number_outlined, size: 18),
            const SizedBox(width: 8),
            Text(
              'Bayar ${_formatPrice(_totalPrice)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers UI ────────────────────────────────────────────────
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: _navy,
      ),
    );
  }

  Widget _card({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EFF8)),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // ── FIX: Handle Booking dengan finally + timeout ──────────────
  Future<void> _handleBooking() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );

    if (authProvider.userId == null) {
      _showSnackBar('Silakan login terlebih dahulu', isError: true);
      return;
    }

    // ── FASE 1: Buat booking ──────────────────────────────────
    setState(() => _isCreatingBooking = true);

    late String bookingId;

    try {
      final booking = await bookingProvider
          .createBooking(
            userId: authProvider.userId!,
            destinationId: widget.destinationId,
            destinationName: widget.destinationName,
            visitDate: _selectedDate,
            quantity: _quantity,
            pricePerTicket: widget.ticketPrice,
          )
          // FIX: timeout 15 detik agar tidak muter selamanya
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw Exception('Koneksi timeout. Coba lagi.'),
          );

      bookingId = booking.bookingId;
    } catch (e) {
      // FIX: selalu reset loading di finally lewat flag
      if (mounted) setState(() => _isCreatingBooking = false);
      _showSnackBar(_cleanError(e), isError: true);
      return; // keluar, tidak lanjut ke payment
    }

    // FASE 1 selesai
    if (mounted) {
      setState(() {
        _isCreatingBooking = false;
        _isProcessingPayment = true; // masuk fase 2
      });
    }

    // ── FASE 2: Proses pembayaran ─────────────────────────────
    try {
      await bookingProvider
          .processBookingPayment(
            bookingId: bookingId,
            method: _selectedPaymentMethod,
          )
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw Exception(
              'Proses pembayaran timeout. Cek riwayat pesanan.',
            ),
          );

      // Sukses
      if (mounted) {
        setState(() => _isProcessingPayment = false);
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessingPayment = false);
        _showSnackBar(_cleanError(e), isError: true);
      }
    }
    // FIX: tidak perlu finally karena setiap branch sudah reset flag
  }

  // ── Success Dialog ────────────────────────────────────────────
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tiket ${widget.destinationName} berhasil dipesan untuk ${_formatDate(_selectedDate)}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
              ),
              const SizedBox(height: 20),
              Text(
                _formatPrice(_totalPrice),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_quantity tiket · ${_paymentMethodLabel()}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF99AABB)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // tutup dialog
                    Navigator.pop(context); // kembali ke home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _navyDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Selesai',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────
  String _paymentMethodLabel() {
    switch (_selectedPaymentMethod) {
      case PaymentMethod.qris:
        return 'QRIS';
      case PaymentMethod.eWallet:
        return 'E-Wallet';
      case PaymentMethod.bankTransfer:
        return 'Transfer Bank';
    }
  }

  /// Bersihkan pesan error dari prefix Exception/flutter
  String _cleanError(Object e) {
    final msg = e.toString();
    if (msg.startsWith('Exception: ')) {
      return msg.replaceFirst('Exception: ', '');
    }
    return msg;
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
