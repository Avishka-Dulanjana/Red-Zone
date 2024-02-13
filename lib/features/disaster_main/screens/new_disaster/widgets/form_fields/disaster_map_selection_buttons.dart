import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              var result = await Get.to(() => GoogleMapScreen(
                    isSelecting: true,
                    onSaveCustomMarkerCallback: () {},
                    onLocationPicked: (PlaceLocation? pickedLocation) {
                      if (pickedLocation != null) {
                        controller.pickedLocation.value = pickedLocation; // Use the updated location
                      }
                    },
                  ));

              if (result != null && result is PlaceLocation) {
                print('Picked location: ${result.latitude}, ${result.longitude}');
              }
            },
            child: const Text(TTexts.selectOnMap),
          ),
        ),
      ],
    );
  }
}
