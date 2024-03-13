import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/prediction_controller.dart';

class PredictionForm extends StatelessWidget {
  const PredictionForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final predictionController = Get.put(PredictionController());

    return Form(
      child: Column(
        children: [
          Text(' Monthly Disaster Risk Predictions with AI',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(decoration: TextDecoration.underline, overflow: TextOverflow.ellipsis, decorationColor: Colors.white, decorationThickness: 1.5, color: TColors.white)),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
            decoration: const InputDecoration(
                labelText: TTexts.disasterType, labelStyle: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16), prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
            onChanged: (value) {
              predictionController.setDisasterType(value!); // Set the selected disaster type
            },
            items: ["Flood", "Land Slide", "Earthquake", "Tsunami", "Storm"]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.month, value),
            decoration: const InputDecoration(
                labelText: TTexts.month, labelStyle: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16), prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
            onChanged: (value) {
              predictionController.setMonth(value!); // Set the selected month
            },
            items: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.white,
              ),
              onPressed: () {
                predictionController.launchPrediction(); // Call the launchPrediction method from PredictionController
              },
              child: const Text(TTexts.prediction, style: TextStyle(color: TColors.black)),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        ],
      ),
    );
  }
}
