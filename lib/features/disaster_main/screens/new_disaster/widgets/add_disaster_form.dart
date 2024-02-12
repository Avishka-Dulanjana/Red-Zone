import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:red_zone/features/disaster_main/controller/disaster_controller.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class AddDisasterForm extends StatelessWidget {
  const AddDisasterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisasterController());

    return Form(
      key: controller.addDisasterFormKey,
      child: Column(children: [
        // Dropdown Disaster Type
        DropdownButtonFormField(
          validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
          decoration: const InputDecoration(labelText: TTexts.disasterType, prefixIcon: Icon(Iconsax.sort_copy)),
          onChanged: (value) {
            DisasterController.instance.disasterType.value = value.toString();
          },
          items: ["Flood", "Land Slide", "Earthquake", "Tsunami", "Storm"]
              .map(
                (option) => DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
        ),

        // Dropdown Province
        Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwInputFields),
          child: DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterProvince, value),
            decoration: const InputDecoration(labelText: TTexts.disasterProvince, prefixIcon: Icon(Iconsax.sort_copy)),
            onChanged: (value) {
              DisasterController.instance.disasterProvince.value = value.toString();
            },
            items: [
              "Central Province",
              "Eastern Province",
              "North Central Province",
              "Northern Province",
              "North Western Province",
              "Sabaragamuwa Province",
              "Southern Province",
              "Uva Province",
              "Western Province"
            ]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Description
        TextFormField(
          controller: controller.disasterDescription,
          validator: (value) => TValidator.validateEmptyText(TTexts.description, value),
          expands: false,
          maxLines: 3,
          decoration: const InputDecoration(labelText: TTexts.description, prefixIcon: Icon(Iconsax.user_edit)),
        ),

        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Image on disaster
        GestureDetector(
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
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map details
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          width: double.infinity,
          height: TSizes.disasterImageSize,
          child: Obx(() {
            // Display the map image if location is selected
            if (controller.pickedLocation.value != null) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  child: Image.network(controller.locationImage.value, fit: BoxFit.cover, width: double.infinity, height: TSizes.disasterImageSize));
            } else {
              // Display icon when no location is selected
              return IconButton(
                icon: const Icon(Iconsax.map, size: TSizes.iconMd),
                tooltip: TTexts.cancel,
                onPressed: () {
                  controller.getLocation();
                },
              );
            }
          }),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Row(children: [
          Expanded(
              child: OutlinedButton(
            onPressed: () => controller.getLocation(),
            child: const Text(TTexts.selectOnCurrentLocation),
          )),
          const SizedBox(width: TSizes.spaceBtwInputFields),
          Expanded(
              child: OutlinedButton(
            onPressed: () {},
            child: const Text(TTexts.selectOnMap),
          )),
        ]),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Save button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.saveDisasterRecord(),
            child: const Text(TTexts.addDisaster),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Cancel button
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            child: const Text(TTexts.cancel),
          ),
        ),
      ]),
    );
  }
}
