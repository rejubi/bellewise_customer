import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Position? _currentPosition;
  static String? _currentAddress;

  static Position? get currentPosition => _currentPosition;
  static String? get currentAddress => _currentAddress;

  static Future<void> initialize() async {
    try {
      await _requestPermission();
      await _loadCurrentLocation();
    } catch (_) {
      // Ignore location errors
    }
  }

  static Future<void> _requestPermission() async {
    final serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    var permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    if (permission ==
        LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      throw Exception("Location permission denied.");
    }
  }

  static Future<void> _loadCurrentLocation() async {
    _currentPosition =
    await Geolocator.getCurrentPosition(
      desiredAccuracy:
      LocationAccuracy.medium,
    );

    final placemarks =
    await placemarkFromCoordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;

      _currentAddress = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
      ]
          .where((e) =>
      e != null &&
          e.trim().isNotEmpty)
          .join(", ");
    }
  }

  static Future<String?> refresh() async {
    try {
      await _requestPermission();
      await _loadCurrentLocation();
      return _currentAddress;
    } catch (_) {
      return _currentAddress;
    }
  }

  static Future<String?> getCurrentAddress() async {
    if (_currentAddress == null ||
        _currentAddress!.isEmpty) {
      await refresh();
    }

    return _currentAddress;
  }

  static Future<bool> hasPermission() async {
    final serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    final permission =
    await Geolocator.checkPermission();

    return permission ==
        LocationPermission.always ||
        permission ==
            LocationPermission.whileInUse;
  }
}