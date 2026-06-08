import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class LocationService {
  static const double _earthRadiusKm = 6371; // Radius bumi dalam km

  // Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  // Check location permission
  Future<bool> isLocationPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // Enable location services
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get current position
  Future<Position> getCurrentPosition() async {
    try {
      final hasPermission = await isLocationPermissionGranted();
      if (!hasPermission) {
        await requestLocationPermission();
      }

      final isEnabled = await isLocationServiceEnabled();
      if (!isEnabled) {
        throw Exception('Layanan lokasi tidak diaktifkan');
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      throw Exception('Gagal mendapatkan lokasi: $e');
    }
  }

  // Get current latitude & longitude
  Future<Map<String, double>> getCurrentCoordinates() async {
    try {
      final position = await getCurrentPosition();
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      throw Exception('Gagal mendapatkan koordinat: $e');
    }
  }

  // Calculate distance between two coordinates (in kilometers)
  double calculateDistance({
    required double userLat,
    required double userLng,
    required double destinationLat,
    required double destinationLng,
  }) {
    final lat1Rad = _degreesToRadians(userLat);
    final lat2Rad = _degreesToRadians(destinationLat);
    final deltaLat = _degreesToRadians(destinationLat - userLat);
    final deltaLng = _degreesToRadians(destinationLng - userLng);

    final a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return _earthRadiusKm * c;
  }

  // Calculate distance from current location to destination
  Future<double> getDistanceToDestination({
    required double destinationLat,
    required double destinationLng,
  }) async {
    try {
      final currentPosition = await getCurrentPosition();
      return calculateDistance(
        userLat: currentPosition.latitude,
        userLng: currentPosition.longitude,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
      );
    } catch (e) {
      throw Exception('Gagal menghitung jarak: $e');
    }
  }

  // Get real-time location stream
  Stream<Position> getLocationStream({
    int distanceFilter = 10, // minimum 10 meter untuk update
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  // Get bearing between two coordinates
  double calculateBearing({
    required double userLat,
    required double userLng,
    required double destinationLat,
    required double destinationLng,
  }) {
    final lat1Rad = _degreesToRadians(userLat);
    final lat2Rad = _degreesToRadians(destinationLat);
    final deltaLng = _degreesToRadians(destinationLng - userLng);

    final y = math.sin(deltaLng) * math.cos(lat2Rad);
    final x = math.cos(lat1Rad) * math.sin(lat2Rad) -
        math.sin(lat1Rad) * math.cos(lat2Rad) * math.cos(deltaLng);

    final bearing = math.atan2(y, x);
    return (_radiansToDegrees(bearing) + 360) % 360;
  }

  // Format distance to readable string
  String formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toStringAsFixed(0)} meter';
    }
    return '${distanceKm.toStringAsFixed(2)} km';
  }

  // Check if user is within radius of destination
  bool isWithinRadius({
    required double userLat,
    required double userLng,
    required double destinationLat,
    required double destinationLng,
    required double radiusKm,
  }) {
    final distance = calculateDistance(
      userLat: userLat,
      userLng: userLng,
      destinationLat: destinationLat,
      destinationLng: destinationLng,
    );
    return distance <= radiusKm;
  }

  // Convert degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  // Convert radians to degrees
  double _radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  // Open location in map
  Future<void> openLocationInMap({
    required double latitude,
    required double longitude,
    required String label,
  }) async {
    final query = Uri.encodeComponent(label);
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      if (await Geolocator.isLocationServiceEnabled()) {
        // Implementasi bisa dikembangkan dengan package like url_launcher
      }
    } catch (e) {
      throw Exception('Gagal membuka maps: $e');
    }
  }
}
