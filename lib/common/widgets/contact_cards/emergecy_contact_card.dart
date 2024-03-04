import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/circular_image.dart';
import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';

class TEmergencyContactCard extends StatelessWidget {
  const TEmergencyContactCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.contactNo,
    required this.contactDepartment,
  });

  final bool showBorder;
  final void Function()? onTap;
  final String contactNo;
  final String contactDepartment;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        boarderColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: dark ? TColors.black : TColors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.google,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(contactNo, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        contactDepartment,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Icon(Iconsax.verify, color: TColors.primary, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
