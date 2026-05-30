import 'package:flutter/material.dart';
import '../data/wisata_data.dart';
import '../models/wisata_model.dart';
import '../widgets/wisata_card.dart';
import '../widgets/filter_sheet.dart';

class DaftarWisataPage extends StatefulWidget {
  const DaftarWisataPage({super.key});
  @override
  State<DaftarWisataPage> createState() => _DaftarWisataPageState();
}

class _DaftarWisataPageState extends State<DaftarWisataPage> {
  String _selectedKategori = 'Semua';
  String _searchQuery = '';

  final List<String> _kategori = [
    'Semua',
    'Alam',
    'Budaya',
    'Pantai',
    'Agrowisata',
  ];

  List<WisataItem> get _filtered => dataWisata.where((w) {
    final matchK =
        _selectedKategori == 'Semua' || w.kategori == _selectedKategori;
    final matchS =
        _searchQuery.isEmpty ||
        w.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        w.lokasi.toLowerCase().contains(_searchQuery.toLowerCase());
    return matchK && matchS;
  }).toList();

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FilterSheet(
        selected: _selectedKategori,
        onSelect: (k) {
          setState(() => _selectedKategori = k);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        title: const Text(
          'Daftar Wisata',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: const InputDecoration(
                  hintText: 'Cari wisata atau lokasi...',
                  hintStyle: TextStyle(color: Colors.black38),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2D6A4F)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _kategori.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final k = _kategori[i];
                final sel = k == _selectedKategori;
                return GestureDetector(
                  onTap: () => setState(() => _selectedKategori = k),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? const Color(0xFF2D6A4F) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel ? const Color(0xFF2D6A4F) : Colors.black12,
                      ),
                    ),
                    child: Text(
                      k,
                      style: TextStyle(
                        color: sel ? Colors.white : const Color(0xFF555555),
                        fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} tempat ditemukan',
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 12),
                        Text(
                          'Tidak ada wisata ditemukan',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: WisataCard(item: _filtered[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
