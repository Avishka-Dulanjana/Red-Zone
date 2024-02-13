import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

import 'package:red_zone/features/disaster_main/controller/disaster_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../models/disaster_model.dart';
import 'form_fields/disaster_description_field.dart';
import 'form_fields/disaster_image_pick.dart';
import 'form_fields/disaster_map_selection.dart';
import 'form_fields/disaster_map_selection_buttons.dart';

class AddDisasterForm extends StatelessWidget {
  AddDisasterForm({super.key});

  final pickedLocation = Rx<PlaceLocation?>(null);

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
        DisasterDescriptionField(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Image on disaster
        DisasterImagePick(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map details
        const DisasterMapSelection(),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map selection buttons
        MapSelectionButtons(controller: controller),
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
            onPressed: () {
              Get.back();
            },
            child: const Text(TTexts.cancel),
          ),
        ),
      ]),
    );
  }
}
