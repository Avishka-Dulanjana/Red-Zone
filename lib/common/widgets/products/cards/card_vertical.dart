import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../styles/product_title_text.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/circular_image.dart';
import '../../images/rounded_disaster_image.dart';

class TVerticalCard extends StatelessWidget {
  const TVerticalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            // Details
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
                    title: TProductTitleText(title: 'Flood in Sri Lanka', smallSize: true, maxLines: 1),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Avishka Dulanjana', overflow: TextOverflow.ellipsis),
                        SizedBox(width: TSizes.spaceBtwItems / 4),
                        Icon(Iconsax.verify, color: TColors.primary, size: TSizes.iconXs),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                ],
              ),
            ),

            // Thumbnail
            TRoundedContainer(
              height: 360,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: const Stack(
                children: [
                  TRoundedDisasterImage(
                    imageUrl: TImages.disasterImage,
                    applyImageRadius: true,
                    width: double.infinity,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Align buttons in the center horizontally
              children: [
                SizedBox(
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: TColors.primary,
                        minimumSize: const Size(150, 50),
                        padding: const EdgeInsets.all(TSizes.sm),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      icon: const Icon(Iconsax.heart),
                      label: const Text('Like')),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                SizedBox(
                  child: OutlinedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(150, 50),
                        padding: const EdgeInsets.all(TSizes.sm),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('Preview')),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
