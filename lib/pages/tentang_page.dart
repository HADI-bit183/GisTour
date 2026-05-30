import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF2D6A4F),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Tentang GisTour',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B4332), Color(0xFF52B788)],
                  ),
                ),
                child: const Center(
                  child: Text('🏡', style: TextStyle(fontSize: 60)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoCard(
                    '🌿 Tentang GisTour',
                    'GisTour adalah aplikasi mobile berbasis GIS untuk membantu wisatawan menemukan destinasi wisata di wilayah Gisting, Tanggamus, Lampung.',
                  ),
                  const SizedBox(height: 14),
                  _infoCard(
                    '🎯 Misi Kami',
                    'Memudahkan wisatawan memilih destinasi yang sesuai kebutuhan, sekaligus membantu promosi desa wisata Gisting agar semakin dikenal luas.',
                  ),
                  const SizedBox(height: 14),
                  _infoCard(
                    '📋 Fitur Aplikasi',
                    '• Daftar wisata lengkap dengan kategori\n• Detail wisata: lokasi, fasilitas, jam buka\n• Peta lokasi interaktif\n• Filter berdasarkan kategori\n• Rating & ulasan pengunjung\n• Pencarian cepat',
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Text('🇮🇩', style: TextStyle(fontSize: 36)),
                        SizedBox(height: 8),
                        Text(
                          'Bangga Produk Lokal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mendukung pariwisata desa Gisting',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Versi 1.0.0',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String judul, String isi) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4332),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isi,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}
