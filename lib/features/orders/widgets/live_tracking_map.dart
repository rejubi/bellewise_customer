import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/theme.dart';
import '../models/tracking_model.dart';

class LiveTrackingMap extends StatelessWidget {
  final TrackingModel tracking;

  const LiveTrackingMap({
    super.key,
    required this.tracking,
  });

  @override
  Widget build(BuildContext context) {
    if (!tracking.hasRider ||
        tracking.latitude == null ||
        tracking.longitude == null) {
      return const SizedBox();
    }

    final riderPosition = LatLng(
      tracking.latitude!,
      tracking.longitude!,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 250,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: riderPosition,
            zoom: 15,
          ),

          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,

          markers: {
            Marker(
              markerId: const MarkerId("rider"),
              position: riderPosition,
              infoWindow: InfoWindow(
                title: tracking.riderName ?? "Rider",
                snippet: tracking.vehicle ?? "",
              ),
            ),
          },
        ),
      ),
    );
  }
}