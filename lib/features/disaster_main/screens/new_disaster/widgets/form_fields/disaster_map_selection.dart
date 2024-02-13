import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../controller/disaster_controller.dart';
import '../../../../controller/google_map_controller.dart';

class DisasterMapSelection extends StatelessWidget {
  const DisasterMapSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisasterController());
    final controller2 = Get.put(GoogleMapController());
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      width: double.infinity,
      height: TSizes.disasterImageSize,
      child: Obx(() {
        // Display the map image if location is selected
        if (controller.locationImage.value.isNotEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            child: Image.network(
              controller.locationImage.value,
              fit: BoxFit.cover,
              width: double.infinity,
              height: TSizes.disasterImageSize,
            ),
          );
        } else if (controller2.googleMapLocation.value.isNotEmpty) {
          // Display the map image if location is selected
          return ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              child: Image.network(
                controller2.googleMapLocation.value,
                fit: BoxFit.cover,
                width: double.infinity,
                height: TSizes.disasterImageSize,
              ));
        } else {
          // Display icon when no location is selected
          return IconButton(
            icon: const Icon(Iconsax.map, size: TSizes.iconMd),
            tooltip: TTexts.cancel,
            onPressed: () {
              controller.getLocation();
            },
          );
        } // or any other default widget
      }),
    );
  }
}
