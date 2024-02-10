import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_zone/features/disaster_main/controller/disaster_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class AddDisasterForm extends StatelessWidget {
  const AddDisasterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = DisasterController.instance;
    return Form(
      child: Column(children: [
        // Dropdown Disaster Type
        DropdownButtonFormField(
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
        TextFormField(
          controller: controller.disasterDescription,
          validator: (value) => TValidator.validateEmptyText(TTexts.username, value),
          expands: false,
          maxLines: 3,
          decoration: const InputDecoration(labelText: TTexts.description, prefixIcon: Icon(Iconsax.user_edit), hintMaxLines: 3),
        ),

        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Image
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          width: double.infinity,
          height: TSizes.disasterImageSize,
          child: IconButton(
              icon: const Icon(Iconsax.camera, size: TSizes.iconMd),
              onPressed: () {
                ImagePicker().pickImage(source: ImageSource.camera);
              }),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          width: double.infinity,
          height: TSizes.disasterImageSize,
          child: IconButton(
              icon: const Icon(Iconsax.map, size: TSizes.iconMd),
              tooltip: TTexts.cancel,
              onPressed: () {
                ImagePicker().pickImage(source: ImageSource.gallery);
              }),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Row(children: [
          Expanded(
              child: OutlinedButton(
            onPressed: () {},
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
