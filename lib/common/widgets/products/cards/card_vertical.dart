import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/disaster_detail.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/product_title_text.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/circular_image.dart';
import '../../images/rounded_disaster_image.dart';

class TVerticalCard extends StatelessWidget {
  const TVerticalCard({super.key, required this.disaster});

  final DisasterModel disaster;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    String formattedDate = DateFormat('yyyy-MM-dd').format(disaster.createdAt);
    String formattedTime = DateFormat('HH:mm a').format(disaster.createdAt);
    String formattedDateTime = '$formattedDate at $formattedTime';

    return GestureDetector(
      onTap: () => Get.to(() => DisasterDetails(disaster: disaster)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // User Profile Image
              leading: TCircularImage(
                image: disaster.user!.profilePicture,
                width: 50,
                height: 50,
                padding: 0,
                isNetworkImage: true,
              ),
              title: TProductTitleText(title: '${disaster.disasterType} in ${disaster.disasterDistrict}, ${disaster.disasterProvince}', smallSize: false, maxLines: 1),
              subtitle: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(disaster.user!.fullName, overflow: TextOverflow.ellipsis),
                    const SizedBox(width: 4),
                    const Icon(Iconsax.verify, color: TColors.primary, size: TSizes.iconXs),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDateTime,
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
            ),
            const SizedBox(height: 8),
            TRoundedContainer(
              height: 370,
              padding: const EdgeInsets.all(8),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  TRoundedDisasterImage(
                    imageUrl: disaster.disasterImageUrls?.isNotEmpty == true ? disaster.disasterImageUrls!.first : '', // Check if the list is not empty before accessing its first element
                    applyImageRadius: true,
                    isNetworkImage: true,
                    width: double.infinity,
                    height: 370,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement Like functionality
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: TColors.primary,
                    minimumSize: const Size(150, 50),
                    padding: const EdgeInsets.all(8),
                  ),
                  icon: const Icon(Iconsax.heart),
                  label: const Text('Like'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    // Implement Preview functionality
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(150, 50),
                    padding: const EdgeInsets.all(2),
                  ),
                  child: const Text('Preview'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
