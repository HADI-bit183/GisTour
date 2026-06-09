import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  static const LatLng _gistingCenter = LatLng(-5.3830, 104.6240);

  final MapController _mapController = MapController();
  LatLng? _userLocation;
  bool _loadingLocation = false;
  String? _selectedDestName;
  String? _selectedDestKategori;

  static const List<Map<String, dynamic>> _destinations = [
    {
      'id': 'dst_1',
      'name': 'Air Terjun Way Lalaan',
      'kategori': 'Alam',
      'lat': -5.3672,
      'lng': 104.6185,
    },
    {
      'id': 'dst_2',
      'name': 'Kebun Teh Gisting',
      'kategori': 'Alam',
      'lat': -5.3910,
      'lng': 104.6310,
    },
    {
      'id': 'dst_3',
      'name': 'Gunung Tanggamus',
      'kategori': 'Petualangan',
      'lat': -5.4200,
      'lng': 104.6500,
    },
    {
      'id': 'dst_4',
      'name': 'Danau Teluk',
      'kategori': 'Alam',
      'lat': -5.3750,
      'lng': 104.5900,
    },
    {
      'id': 'dst_5',
      'name': 'Air Terjun Banyu Ujung',
      'kategori': 'Alam',
      'lat': -5.3550,
      'lng': 104.6050,
    },
    {
      'id': 'dst_6',
      'name': 'Wisata Agro Gisting',
      'kategori': 'Agrowisata',
      'lat': -5.3870,
      'lng': 104.6270,
    },
    {
      'id': 'dst_7',
      'name': 'Puncak Mas Gisting',
      'kategori': 'Panorama',
      'lat': -5.3790,
      'lng': 104.6380,
    },
    {
      'id': 'dst_8',
      'name': 'Bumi Perkemahan Gisting',
      'kategori': 'Petualangan',
      'lat': -5.3820,
      'lng': 104.6420,
    },
  ];

  Color _markerColor(String kategori) {
    switch (kategori) {
      case 'Petualangan':
        return const Color(0xFFFF9800);
      case 'Agrowisata':
        return const Color(0xFF4CAF50);
      case 'Panorama':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFF2196F3);
    }
  }

  IconData _markerIcon(String kategori) {
    switch (kategori) {
      case 'Petualangan':
        return Icons.terrain_rounded;
      case 'Agrowisata':
        return Icons.agriculture_rounded;
      case 'Panorama':
        return Icons.landscape_rounded;
      default:
        return Icons.forest_rounded;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    setState(() => _loadingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (_) {
      // Lokasi tidak tersedia
    } finally {
      if (mounted) setState(() => _loadingLocation = false);
    }
  }

  void _goToMyLocation() {
    if (_userLocation != null) {
      _mapController.move(_userLocation!, 14);
    } else {
      _getUserLocation();
    }
  }

  void _goToGisting() {
    _mapController.move(_gistingCenter, 13);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          _buildHeader(),
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
                child: Stack(
                  children: [
                    // ── OpenStreetMap ────────────────────────
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: _gistingCenter,
                        initialZoom: 13,
                        onTap: (_, _) => setState(() {
                          _selectedDestName = null;
                          _selectedDestKategori = null;
                        }),
                      ),
                      children: [
                        // Tile layer OpenStreetMap
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.gistour.app',
                        ),

                        // Marker destinasi wisata
                        MarkerLayer(
                          markers: [
                            // Marker user location
                            if (_userLocation != null)
                              Marker(
                                point: _userLocation!,
                                width: 40,
                                height: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.person_pin_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),

                            // Marker tiap destinasi
                            ..._destinations.map((dest) {
                              final color = _markerColor(dest['kategori']);
                              final isSelected =
                                  _selectedDestName == dest['name'];
                              return Marker(
                                point: LatLng(dest['lat'], dest['lng']),
                                width: isSelected ? 48 : 40,
                                height: isSelected ? 48 : 40,
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _selectedDestName = dest['name'];
                                    _selectedDestKategori = dest['kategori'];
                                  }),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                        width: isSelected ? 3 : 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withValues(alpha: 0.5),
                                          blurRadius: isSelected ? 12 : 6,
                                          spreadRadius: isSelected ? 2 : 0,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _markerIcon(dest['kategori']),
                                      color: Colors.white,
                                      size: isSelected ? 24 : 18,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),

                    // ── Legenda ──────────────────────────────
                    Positioned(top: 12, left: 12, child: _buildLegend()),

                    // ── FAB ──────────────────────────────────
                    Positioned(
                      bottom: 24,
                      right: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'fab_reset',
                            onPressed: _goToGisting,
                            backgroundColor: Colors.white,
                            foregroundColor: _blue,
                            tooltip: 'Kembali ke Gisting',
                            child: const Icon(Icons.map_outlined),
                          ),
                          const SizedBox(height: 8),
                          FloatingActionButton.small(
                            heroTag: 'fab_location',
                            onPressed: _goToMyLocation,
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            tooltip: 'Lokasi Saya',
                            child: _loadingLocation
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.my_location_rounded),
                          ),
                        ],
                      ),
                    ),

                    // ── Info chip destinasi terpilih ─────────
                    if (_selectedDestName != null)
                      Positioned(
                        bottom: 24,
                        left: 16,
                        right: 80,
                        child: _buildSelectedChip(),
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

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
        child: Row(
          children: [
            const Icon(Icons.map_rounded, color: Colors.white, size: 26),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peta Wisata',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Gisting, Kabupaten Tanggamus',
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.place_rounded,
                    color: Colors.white70,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_destinations.length} Destinasi',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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

  Widget _buildLegend() {
    final items = [
      {'label': 'Alam', 'color': const Color(0xFF2196F3)},
      {'label': 'Petualangan', 'color': const Color(0xFFFF9800)},
      {'label': 'Agrowisata', 'color': const Color(0xFF4CAF50)},
      {'label': 'Panorama', 'color': const Color(0xFF9C27B0)},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: item['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSelectedChip() {
    final color = _markerColor(_selectedDestKategori ?? 'Alam');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.place_rounded, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedDestName!,
                  style: const TextStyle(
                    color: _navy,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _selectedDestKategori ?? '',
                  style: TextStyle(color: color, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
