import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── Warna tema (sama dengan HomePage & EventPage) ───────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          // ── Header ─────────────────────────────────────────
          _buildHeader(),

          // ── Body ───────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: _bodyBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: Consumer<BookingProvider>(
                  builder: (context, bookingProvider, _) {
                    if (bookingProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: _blue),
                      );
                    }

                    if (bookingProvider.bookings.isEmpty) {
                      return _buildEmptyState();
                    }

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildTicketList(
                          bookingProvider.bookings
                              .where((b) => b.paymentStatus == 'paid')
                              .toList(),
                          'Tidak ada tiket aktif',
                        ),
                        _buildTicketList(
                          bookingProvider.bookings
                              .where((b) => b.bookingStatus == 'used')
                              .toList(),
                          'Tidak ada tiket terpakai',
                        ),
                        _buildTicketList(
                          bookingProvider.bookings
                              .where(
                                (b) =>
                                    b.bookingStatus == 'cancelled' ||
                                    b.paymentStatus == 'failed',
                              )
                              .toList(),
                          'Tidak ada riwayat',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: _navyDark,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.of(context).padding.top + 18,
        22,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Koleksi Tiket Kamu 🎟️',
                      style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tiket Saya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.13),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.confirmation_number_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0x73FFFFFF),
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              Tab(text: 'Aktif'),
              Tab(text: 'Terpakai'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE (belum ada tiket sama sekali) ─────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              size: 40,
              color: _blue,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada tiket',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pesan tiket untuk mulai menjelajahi',
            style: TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ],
      ),
    );
  }

  // ── TICKET LIST ───────────────────────────────────────────
  Widget _buildTicketList(List<BookingModel> tickets, String emptyMessage) {
    if (tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.inbox_rounded, size: 30, color: _blue),
            ),
            const SizedBox(height: 12),
            Text(
              emptyMessage,
              style: const TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
      itemCount: tickets.length,
      itemBuilder: (context, index) => _TicketCard(
        ticket: tickets[index],
        onTap: () => _showTicketDetail(context, tickets[index]),
      ),
    );
  }

  // ── BOTTOM SHEET DETAIL ───────────────────────────────────
  void _showTicketDetail(BuildContext context, BookingModel ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Detail Tiket',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _navy,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: _navy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Destination info card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.landscape_rounded,
                          color: _blue,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.destinationName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _navy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 12,
                                  color: _blue,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(ticket.visitDate),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF4A6080),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _StatusBadge(status: ticket.paymentStatus),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // QR Code
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE8EFF8)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Scan untuk masuk',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF99AABB),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14),
                      QrImageView(
                        data: ticket.qrCode ?? ticket.bookingId,
                        version: QrVersions.auto,
                        size: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ticket.bookingId,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF99AABB),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Informasi Tiket
                _buildInfoCard(
                  'Informasi Tiket',
                  Icons.confirmation_number_outlined,
                  [
                    _buildRow('ID Booking', ticket.bookingId),
                    _buildRow('Jumlah Tiket', '${ticket.quantity} tiket'),
                    _buildRow(
                      'Tanggal Kunjung',
                      DateFormat('dd MMM yyyy').format(ticket.visitDate),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Rincian Harga
                _buildInfoCard('Rincian Harga', Icons.receipt_outlined, [
                  _buildRow(
                    'Harga Satuan',
                    'Rp ${_fmt(ticket.pricePerTicket)}',
                  ),
                  _buildRow('Jumlah', '${ticket.quantity}x'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(height: 1, color: Color(0xFFE8EFF8)),
                  ),
                  _buildRow(
                    'Total',
                    'Rp ${_fmt(ticket.totalPrice)}',
                    bold: true,
                    valueColor: _blue,
                  ),
                ]),
                const SizedBox(height: 24),

                // Tombol aksi
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _navyDark,
                          side: const BorderSide(color: Color(0xFFDDEAF5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Tutup'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.share_rounded, size: 16),
                        label: const Text('Bagikan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _navyDark,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── HELPERS ───────────────────────────────────────────────
  String _fmt(double v) => v
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EFF8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: _blue),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE8EFF8)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF99AABB)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: valueColor ?? _navy,
            ),
          ),
        ],
      ),
    );
  }
}

// ── TICKET CARD ────────────────────────────────────────────────
class _TicketCard extends StatelessWidget {
  final BookingModel ticket;
  final VoidCallback onTap;

  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);

  const _TicketCard({required this.ticket, required this.onTap});

  String _fmt(double v) => v
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8EFF8)),
        ),
        child: Column(
          children: [
            // ── Strip atas berwarna ────────────────────────
            Container(
              height: 5,
              decoration: BoxDecoration(
                color: _getStatusColor(ticket.paymentStatus),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama + badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.landscape_rounded,
                          color: _blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.destinationName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _navy,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 11,
                                  color: Color(0xFF99AABB),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(ticket.visitDate),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF99AABB),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _StatusBadge(status: ticket.paymentStatus),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Garis putus (efek tiket)
                  Row(
                    children: List.generate(
                      28,
                      (i) => Expanded(
                        child: Container(
                          height: 1,
                          color: i.isEven
                              ? const Color(0xFFE8EFF8)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Jumlah tiket + total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number_outlined,
                            size: 13,
                            color: Color(0xFF99AABB),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${ticket.quantity} tiket',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF99AABB),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp ${_fmt(ticket.totalPrice)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tombol
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_rounded, size: 16),
                      label: const Text('Lihat Detail & QR Code'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _navyDark,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      onPressed: onTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return const Color(0xFF2E7D32);
      case 'pending':
        return const Color(0xFFF57F17);
      case 'failed':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF90A4AE);
    }
  }
}

// ── STATUS BADGE (shared widget) ───────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      'paid' => ('Lunas', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
      'pending' => (
        'Menunggu',
        const Color(0xFFFFF8E1),
        const Color(0xFFF57F17),
      ),
      'failed' => ('Gagal', const Color(0xFFFFEBEE), const Color(0xFFC62828)),
      _ => ('Status', const Color(0xFFF0F4FC), const Color(0xFF90A4AE)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
