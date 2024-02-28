// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
//
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/validators/validation.dart';
// import '../../../../disaster_main/controller/disaster_controller.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class PredictionForm extends StatelessWidget {
//   const PredictionForm({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final DisasterController controller = Get.put(DisasterController());
//
//     Future<void> _launchUrl() async {
//       final Uri _url = Uri.parse('https://firebasestorage.googleapis.com/v0/b/eredzone-bd711.appspot.com/o/flood_risk_maps%2Fflood%2FApril.html?alt=media&token=7016d46c-be8a-4c01-9990-7ed4ddb2ce62');
//
//       if (!await launchUrl(_url)) {
//         throw 'Could not launch $_url';
//       }
//     }
//
//     return Form(
//       child: Column(
//         children: [
//           Text(
//             ' Monthly Disaster Risk Predictions with AI',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   decoration: TextDecoration.underline,
//                   decorationColor: Colors.white,
//                   decorationThickness: 1.5,
//                 ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           DropdownButtonFormField(
//             validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
//             decoration: const InputDecoration(labelText: TTexts.disasterType, prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
//             onChanged: (value) {},
//             items: ["Flood", "Land Slide", "Earthquake", "Tsunami", "Storm"]
//                 .map(
//                   (option) => DropdownMenuItem(value: option, child: Text(option)),
//                 )
//                 .toList(),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           DropdownButtonFormField(
//             validator: (value) => TValidator.validateEmptyText(TTexts.month, value),
//             decoration: const InputDecoration(labelText: TTexts.month, prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
//             onChanged: (value) {},
//             items: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
//                 .map(
//                   (option) => DropdownMenuItem(value: option, child: Text(option)),
//                 )
//                 .toList(),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: TColors.white,
//               ),
//               onPressed: _launchUrl,
//               child: const Text(TTexts.prediction, style: TextStyle(color: TColors.black)),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
    final predictionController = Get.put(PredictionController()); // Use PredictionController

    return Form(
      child: Column(
        children: [
          Text(
            ' Monthly Disaster Risk Predictions with AI',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1.5,
                ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
            decoration: const InputDecoration(labelText: TTexts.disasterType, prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
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
            decoration: const InputDecoration(labelText: TTexts.month, prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
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
