import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // ── Warna tema ──────────────────────────────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  // ── Map ─────────────────────────────────────────────────────
  final Completer<GoogleMapController> _mapController = Completer();
  static const LatLng _gistingCenter = LatLng(-5.3830, 104.6240);

  final Set<Marker> _markers = {};
  LatLng? _userLocation;
  bool _loadingLocation = false;
  String? _selectedDestName;

  // ── Destinasi wisata Gisting (koordinat asli) ────────────────
  static const List<Map<String, dynamic>> _destinations = [
    {
      'id': 'dst_1',
      'name': 'Air Terjun Way Lalaan',
      'kategori': 'Alam',
      'lat': -5.3672,
      'lng': 104.6185,
      'icon': '🌊',
    },
    {
      'id': 'dst_2',
      'name': 'Kebun Teh Gisting',
      'kategori': 'Alam',
      'lat': -5.3910,
      'lng': 104.6310,
      'icon': '🌿',
    },
    {
      'id': 'dst_3',
      'name': 'Gunung Tanggamus',
      'kategori': 'Petualangan',
      'lat': -5.4200,
      'lng': 104.6500,
      'icon': '⛰️',
    },
    {
      'id': 'dst_4',
      'name': 'Danau Teluk',
      'kategori': 'Alam',
      'lat': -5.3750,
      'lng': 104.5900,
      'icon': '🏞️',
    },
    {
      'id': 'dst_5',
      'name': 'Air Terjun Banyu Ujung',
      'kategori': 'Alam',
      'lat': -5.3550,
      'lng': 104.6050,
      'icon': '💧',
    },
    {
      'id': 'dst_6',
      'name': 'Wisata Agro Gisting',
      'kategori': 'Agrowisata',
      'lat': -5.3870,
      'lng': 104.6270,
      'icon': '🌾',
    },
    {
      'id': 'dst_7',
      'name': 'Puncak Mas Gisting',
      'kategori': 'Panorama',
      'lat': -5.3790,
      'lng': 104.6380,
      'icon': '🌄',
    },
    {
      'id': 'dst_8',
      'name': 'Bumi Perkemahan Gisting',
      'kategori': 'Petualangan',
      'lat': -5.3820,
      'lng': 104.6420,
      'icon': '⛺',
    },
  ];

  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _buildMarkers();
    _getUserLocation();
  }

  void _buildMarkers() {
    for (final dest in _destinations) {
      _markers.add(
        Marker(
          markerId: MarkerId(dest['id']),
          position: LatLng(dest['lat'], dest['lng']),
          infoWindow: InfoWindow(
            title: dest['name'],
            snippet: dest['kategori'],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _markerHue(dest['kategori']),
          ),
          onTap: () {
            setState(() => _selectedDestName = dest['name']);
          },
        ),
      );
    }
  }

  double _markerHue(String kategori) {
    switch (kategori) {
      case 'Petualangan':
        return BitmapDescriptor.hueOrange;
      case 'Agrowisata':
        return BitmapDescriptor.hueGreen;
      case 'Panorama':
        return BitmapDescriptor.hueViolet;
      default:
        return BitmapDescriptor.hueAzure;
    }
  }

  Future<void> _getUserLocation() async {
    setState(() => _loadingLocation = true);
    try {
      final position = await _locationService.getCurrentPosition();
      final userLatLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _userLocation = userLatLng;
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: userLatLng,
            infoWindow: const InfoWindow(title: 'Lokasi Saya'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );
      });
    } catch (_) {
      // Lokasi tidak tersedia, abaikan
    } finally {
      if (mounted) setState(() => _loadingLocation = false);
    }
  }

  Future<void> _goToMyLocation() async {
    if (_userLocation == null) {
      await _getUserLocation();
    }
    if (_userLocation != null) {
      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(_userLocation!, 14));
    }
  }

  Future<void> _goToGisting() async {
    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_gistingCenter, 13));
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
                child: Stack(
                  children: [
                    // ── Google Map ───────────────────────────
                    GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: _gistingCenter,
                        zoom: 13,
                      ),
                      onMapCreated: (controller) {
                        _mapController.complete(controller);
                      },
                      markers: _markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      compassEnabled: true,
                      onTap: (_) => setState(() => _selectedDestName = null),
                    ),

                    // ── Legenda warna ────────────────────────
                    Positioned(top: 12, left: 12, child: _buildLegend()),

                    // ── FAB lokasi & reset ───────────────────
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
      {
        'color': BitmapDescriptor.hueAzure,
        'label': 'Alam',
        'paint': const Color(0xFF2196F3),
      },
      {
        'color': BitmapDescriptor.hueOrange,
        'label': 'Petualangan',
        'paint': const Color(0xFFFF9800),
      },
      {
        'color': BitmapDescriptor.hueGreen,
        'label': 'Agrowisata',
        'paint': const Color(0xFF4CAF50),
      },
      {
        'color': BitmapDescriptor.hueViolet,
        'label': 'Panorama',
        'paint': const Color(0xFF9C27B0),
      },
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
                        color: item['paint'] as Color,
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
          const Icon(Icons.place_rounded, color: _blue, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _selectedDestName!,
              style: const TextStyle(
                color: _navy,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
