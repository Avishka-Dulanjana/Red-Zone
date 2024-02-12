import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../models/disaster_model.dart';
import '../../../controller/disaster_controller.dart';

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({
    Key? key,
    required this.location,
    required this.isSelecting,
    required this.onSaveMarker,
    required this.onSaveCustomMarkerCallback,
  }) : super(key: key);

  final PlaceLocation location;
  final bool isSelecting;

  final Function(LatLng?) onSaveMarker;
  final VoidCallback onSaveCustomMarkerCallback;

  final Rx<LatLng?> _pickedLocation = Rx<LatLng?>(null);

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0].street ?? '';
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                onSaveMarker(_pickedLocation.value);
                onSaveCustomMarkerCallback(); // Call the callback provided by the parent
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return GoogleMap(
            onTap: !isSelecting
                ? null
                : (position) async {
                    print('Tapped on the map at: $position');
                    _pickedLocation.value = position;
                    print('_pickedLocation: ${_pickedLocation.value}');
                    setState(() {
                      // Trigger a rebuild
                    });
                  },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                location.latitude,
                location.longitude,
              ),
              zoom: 16,
            ),
            markers: _pickedLocation.value != null && isSelecting
                ? {
                    Marker(
                      markerId: const MarkerId('picked_location'),
                      position: _pickedLocation.value!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                      visible: true,
                    ),
                  }
                : {},
          );
        },
      ),
    );
  }
}
