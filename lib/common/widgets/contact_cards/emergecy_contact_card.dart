import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/circular_image.dart';
import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/features/emergency_contacts/controller/contact_controller.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';

class TEmergencyContactCard extends StatelessWidget {
  const TEmergencyContactCard({
    super.key,
    this.onTap,
    required this.showBorder,
    required this.contact,
  });

  final ContactModel contact;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => ContactController.instance.launchDialPad(contact.contactNo),
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
                image: TImages.phone_02,
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
                      Text(contact.contactNo, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${contact.departmentName} ',
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
