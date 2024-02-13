import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/disaster_controller.dart';

class DisasterImagePick extends StatelessWidget {
  const DisasterImagePick({
    super.key,
    required this.controller,
  });

  final DisasterController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call pickImage method when the image button is pressed
        controller.pickImage();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        width: double.infinity,
        height: TSizes.disasterImageSize,
        child: Obx(() {
          // Check if an image is selected
          if (controller.disasterImage.value.isNotEmpty) {
            // Display the selected image
            return ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                child: Image.file(File(controller.disasterImage.value), width: double.infinity, height: TSizes.disasterImageSize, fit: BoxFit.cover));
          } else {
            // Display icon when no image is selected
            return const Icon(Iconsax.camera, size: TSizes.iconMd);
          }
        }),
      ),
    );
  }
}
