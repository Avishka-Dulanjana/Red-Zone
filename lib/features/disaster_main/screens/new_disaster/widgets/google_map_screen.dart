// GoogleMapScreen class
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/disaster_controller.dart';
import '../../../models/disaster_model.dart';

class GoogleMapScreen extends StatelessWidget {
  final controller = Get.put(DisasterController());

  GoogleMapScreen({
    Key? key,
    required this.location,
    required this.isSelecting,
    this.onSaveCustomMarkerCallback,
    this.onLocationPicked,
  }) : super(key: key);

  final PlaceLocation location;
  final bool isSelecting;
  final VoidCallback? onSaveCustomMarkerCallback;
  final void Function(LatLng?)? onLocationPicked;

  final Rx<LatLng?> pickedLocation2 = Rx<LatLng?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                if (onSaveCustomMarkerCallback != null) {
                  onSaveCustomMarkerCallback!();
                }
                if (onLocationPicked != null) {
                  onLocationPicked!(pickedLocation2.value);
                }
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
                    pickedLocation2.value = position;
                    setState(() {});
                    // Pass the selected location back to the callback function
                    if (onLocationPicked != null) {
                      onLocationPicked!(pickedLocation2.value);
                    }
                  },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                location.latitude,
                location.longitude,
              ),
              zoom: 16,
            ),
            markers: pickedLocation2.value != null && isSelecting
                ? {
                    Marker(
                      markerId: const MarkerId('picked_location'),
                      position: pickedLocation2.value!,
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
