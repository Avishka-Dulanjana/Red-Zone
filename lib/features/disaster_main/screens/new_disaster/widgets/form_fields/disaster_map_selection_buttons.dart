import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../controller/disaster_controller.dart';
import '../../../../models/disaster_model.dart';
import '../google_map_screen.dart';

class MapSelectionButtons extends StatelessWidget {
  const MapSelectionButtons({
    super.key,
    required this.controller,
  });

  final DisasterController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // on select current location button
        Expanded(
          child: OutlinedButton(
            onPressed: () => controller.getLocation(),
            child: const Text(TTexts.selectOnCurrentLocation),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwInputFields),

        // on select map button
        Expanded(
          child: OutlinedButton(
            onPressed: () async {
              await Get.to(() => GoogleMapScreen(
                    isSelecting: true,
                    location: PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
                    onLocationPicked: (LatLng? location) {
                      if (location != null) {
                        controller.pickedLocation.value = PlaceLocation(
                          latitude: location.latitude,
                          longitude: location.longitude,
                          address: '',
                        );
                      }
                    },
                  ));
            },
            child: const Text(TTexts.selectOnMap),
          ),
        ),
      ],
    );
  }
}
