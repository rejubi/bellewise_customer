import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._();

  static Position? _currentPosition;
  static String? _currentAddress;

  static Position? get currentPosition => _currentPosition;

  static String? get currentAddress => _currentAddress;

  // ==========================================================
  // INITIALIZE
  // ==========================================================

  static Future<void> initialize() async {
    try {
      await _requestPermission();
      await _loadCurrentLocation();
    } catch (e) {
      debugPrint(
        "LOCATION INITIALIZATION ERROR: $e",
      );
    }
  }

  // ==========================================================
  // PERMISSION
  // ==========================================================

  static Future<void> _requestPermission() async {
    final serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        "Location services are disabled.",
      );
    }

    var permission =
    await Geolocator.checkPermission();

    debugPrint(
      "LOCATION PERMISSION BEFORE: $permission",
    );

    if (permission ==
        LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    debugPrint(
      "LOCATION PERMISSION AFTER: $permission",
    );

    if (permission ==
        LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      throw Exception(
        "Location permission denied.",
      );
    }
  }

  // ==========================================================
  // LOAD CURRENT LOCATION
  // ==========================================================

  static Future<void> _loadCurrentLocation() async {
    debugPrint(
      "========== GETTING GPS LOCATION ==========",
    );

    Position? position;

    // --------------------------------------------------------
    // LAST KNOWN LOCATION
    // --------------------------------------------------------

    try {
      position =
      await Geolocator.getLastKnownPosition();

      if (position != null) {
        debugPrint(
          "LAST KNOWN LOCATION: "
              "${position.latitude}, "
              "${position.longitude}",
        );
      }
    } catch (e) {
      debugPrint(
        "LAST KNOWN LOCATION ERROR: $e",
      );
    }

    // --------------------------------------------------------
    // FRESH GPS LOCATION
    // --------------------------------------------------------

    try {
      position =
      await Geolocator.getCurrentPosition(
        locationSettings:
        const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      ).timeout(
        const Duration(seconds: 12),
      );

      debugPrint(
        "CURRENT GPS LOCATION: "
            "${position.latitude}, "
            "${position.longitude}",
      );
    } catch (e) {
      debugPrint(
        "CURRENT GPS LOCATION ERROR: $e",
      );

      if (position == null) {
        rethrow;
      }

      debugPrint(
        "USING LAST KNOWN LOCATION.",
      );
    }

    _currentPosition = position;

    if (position == null) {
      throw Exception(
        "Unable to determine current location.",
      );
    }

    // --------------------------------------------------------
    // REVERSE GEOCODING
    // --------------------------------------------------------

    await _getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );
  }

  // ==========================================================
  // REVERSE GEOCODING
  // ==========================================================

  static Future<void> _getAddressFromCoordinates(
      double latitude,
      double longitude,
      ) async {
    debugPrint(
      "========== REVERSE GEOCODING ==========",
    );

    debugPrint(
      "Coordinates: $latitude, $longitude",
    );

    try {
      // Give Android's geocoder a little more time.
      final placemarks =
      await placemarkFromCoordinates(
        latitude,
        longitude,
      ).timeout(
        const Duration(seconds: 15),
      );

      if (placemarks.isEmpty) {
        debugPrint(
          "NO PLACEMARK FOUND.",
        );
        return;
      }

      final place = placemarks.first;

      debugPrint(
        "NAME: ${place.name}",
      );

      debugPrint(
        "STREET: ${place.street}",
      );

      debugPrint(
        "SUBLOCALITY: ${place.subLocality}",
      );

      debugPrint(
        "LOCALITY: ${place.locality}",
      );

      debugPrint(
        "ADMIN AREA: ${place.administrativeArea}",
      );

      debugPrint(
        "POSTAL CODE: ${place.postalCode}",
      );

      // ------------------------------------------------------
      // BUILD FULL ADDRESS
      // ------------------------------------------------------

      final parts = <String>[];

      void addPart(String? value) {
        if (value == null) {
          return;
        }

        final cleaned =
        value.trim();

        if (cleaned.isEmpty) {
          return;
        }

        if (!parts.contains(cleaned)) {
          parts.add(cleaned);
        }
      }

      addPart(place.street);
      addPart(place.subLocality);
      addPart(place.locality);
      addPart(place.administrativeArea);

      // ------------------------------------------------------
      // FALLBACK
      // ------------------------------------------------------

      if (parts.isEmpty) {
        addPart(place.name);
      }

      if (parts.isEmpty) {
        debugPrint(
          "REVERSE GEOCODING RETURNED NO USABLE ADDRESS.",
        );
        return;
      }

      _currentAddress =
          parts.join(", ");

      debugPrint(
        "========== LOCATION ADDRESS ==========",
      );

      debugPrint(
        _currentAddress!,
      );
    } on TimeoutException {
      debugPrint(
        "REVERSE GEOCODING TIMED OUT.",
      );

      debugPrint(
        "GPS coordinates are still available.",
      );
    } catch (e) {
      debugPrint(
        "REVERSE GEOCODING ERROR: $e",
      );

      debugPrint(
        "GPS coordinates are still available.",
      );
    }
  }

  // ==========================================================
  // REFRESH
  // ==========================================================

  static Future<String?> refresh() async {
    try {
      await _requestPermission();

      await _loadCurrentLocation();

      return _currentAddress;
    } catch (e) {
      debugPrint(
        "LOCATION REFRESH ERROR: $e",
      );

      return _currentAddress;
    }
  }

  // ==========================================================
  // GET CURRENT ADDRESS
  // ==========================================================

  static Future<String?> getCurrentAddress() async {
    if (_currentAddress == null ||
        _currentAddress!.trim().isEmpty) {
      await refresh();
    }

    return _currentAddress;
  }

  // ==========================================================
  // CHECK PERMISSION
  // ==========================================================

  static Future<bool> hasPermission() async {
    try {
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
    } catch (e) {
      debugPrint(
        "LOCATION PERMISSION CHECK ERROR: $e",
      );

      return false;
    }
  }

  // ==========================================================
  // CHECK LOCATION SERVICE
  // ==========================================================

  static Future<bool>
  isLocationServiceEnabled() async {
    try {
      return await Geolocator
          .isLocationServiceEnabled();
    } catch (_) {
      return false;
    }
  }
}