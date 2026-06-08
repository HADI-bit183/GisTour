import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/event_model.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ── Warna tema (sama dengan HomePage) ──────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildUpcomingEvents(), _buildAllEvents()],
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
          // Title row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Event & Kegiatan 🎉',
                      style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Wisata Gisting',
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
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Tab bar
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
              Tab(text: 'Mendatang'),
              Tab(text: 'Semua Event'),
            ],
          ),
        ],
      ),
    );
  }

  // ── STREAM BUILDERS (logika tidak berubah) ────────────────
  Widget _buildUpcomingEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .where('eventDate', isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .where('isActive', isEqualTo: true)
          .orderBy('eventDate')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: _blue));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState(
            'Tidak Ada Event Mendatang',
            'Ikuti event wisata di masa depan',
          );
        }
        final events = snapshot.data!.docs
            .map(
              (doc) => EventModel.fromJson(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
          itemCount: events.length,
          itemBuilder: (context, index) => EventCard(
            event: events[index],
            onTap: () => _showEventDetail(context, events[index]),
          ),
        );
      },
    );
  }

  Widget _buildAllEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .where('isActive', isEqualTo: true)
          .orderBy('eventDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: _blue));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState(
            'Tidak Ada Event',
            'Belum ada event yang tersedia',
          );
        }
        final events = snapshot.data!.docs
            .map(
              (doc) => EventModel.fromJson(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
          itemCount: events.length,
          itemBuilder: (context, index) => EventCard(
            event: events[index],
            onTap: () => _showEventDetail(context, events[index]),
          ),
        );
      },
    );
  }

  // ── EMPTY STATE ───────────────────────────────────────────
  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.event_outlined, size: 36, color: _blue),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ],
      ),
    );
  }

  void _showEventDetail(BuildContext context, EventModel event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EventDetailSheet(event: event),
    );
  }
}

// ── EVENT CARD ─────────────────────────────────────────────────
class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);

  const EventCard({super.key, required this.event, required this.onTap});

  String _formatPrice(double price) =>
      'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
    final hasTickets = event.hasTicketsAvailable();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Gambar ────────────────────────────────────
            if (event.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.network(
                  event.imageUrl!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                    ),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: _blue,
                      size: 32,
                    ),
                  ),
                ),
              )
            else
              // Placeholder jika tidak ada gambar
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D2B55), Color(0xFF1565C0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: const Center(
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white54,
                    size: 36,
                  ),
                ),
              ),

            // ── Konten ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul + badge mendatang
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _navy,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (event.isUpcoming()) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            'Mendatang',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tanggal
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 13,
                        color: _blue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        dateFormat.format(event.eventDate),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF99AABB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Lokasi
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 13,
                        color: _blue,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF99AABB),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Divider tipis
                  const Divider(height: 1, color: Color(0xFFE8EFF8)),
                  const SizedBox(height: 10),

                  // Harga + sisa tiket
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatPrice(event.ticketPrice),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _blue,
                        ),
                      ),
                      if (hasTickets)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            '${event.getRemainingTickets()} tiket',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            'Terjual habis',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFC62828),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── EVENT DETAIL SHEET ─────────────────────────────────────────
class EventDetailSheet extends StatelessWidget {
  final EventModel event;

  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);

  const EventDetailSheet({super.key, required this.event});

  String _formatPrice(double price) =>
      'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _navy,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
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
              const SizedBox(height: 16),

              // Gambar
              if (event.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    event.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D2B55), Color(0xFF1565C0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white54,
                      size: 40,
                    ),
                  ),
                ),
              const SizedBox(height: 22),

              // ── Informasi Event ──────────────────────────
              _buildSection('Informasi Event', Icons.info_outline_rounded, [
                _buildRow('Tanggal', dateFormat.format(event.eventDate)),
                _buildRow('Lokasi', event.location),
                if (event.locationDetails != null)
                  _buildRow('Detail Lokasi', event.locationDetails!),
                if (event.organizerName != null)
                  _buildRow('Penyelenggara', event.organizerName!),
              ]),
              const SizedBox(height: 16),

              // ── Deskripsi ────────────────────────────────
              _buildSection('Deskripsi', Icons.article_outlined, [
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: Color(0xFF4A6080),
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              // ── Tiket ────────────────────────────────────
              _buildSection('Tiket', Icons.confirmation_number_outlined, [
                _buildRow('Harga', _formatPrice(event.ticketPrice)),
                if (event.ticketLimit != null)
                  _buildRow('Kapasitas', '${event.ticketLimit} tiket'),
                _buildRow('Terjual', '${event.ticketsSold} tiket'),
                if (event.hasTicketsAvailable())
                  _buildRow(
                    'Tersisa',
                    '${event.getRemainingTickets()} tiket',
                    valueColor: const Color(0xFF2E7D32),
                  )
                else
                  _buildRow(
                    'Status',
                    'Terjual Habis',
                    valueColor: const Color(0xFFC62828),
                  ),
              ]),
              const SizedBox(height: 28),

              // ── Tombol Aksi ──────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.confirmation_number_outlined),
                  label: const Text('Pesan Tiket'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: event.hasTicketsAvailable()
                        ? _navyDark
                        : Colors.grey.shade300,
                    foregroundColor: event.hasTicketsAvailable()
                        ? Colors.white
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: event.hasTicketsAvailable()
                      ? () {
                          // Handle booking
                        }
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
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

  Widget _buildRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
              fontWeight: FontWeight.w600,
              color: valueColor ?? _navy,
            ),
          ),
        ],
      ),
    );
  }
}
