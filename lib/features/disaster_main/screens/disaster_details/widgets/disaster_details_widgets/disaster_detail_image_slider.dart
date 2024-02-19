import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import 'curved_edges_widget.dart';

class TDisasterImageSlider extends StatelessWidget {
  const TDisasterImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(children: [
          const SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Center(
                child: Image(
                  fit: BoxFit.cover,
                  height: 400,
                  image: AssetImage(TImages.disasterImage),
                ),
              ),
            ),
          ),

          // Disaster Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                itemBuilder: (_, index) => TRoundedImage(
                  width: 80,
                  backgroundColor: dark ? TColors.darkerGrey : TColors.light,
                  border: Border.all(color: TColors.black),
                  padding: const EdgeInsets.all(1),
                  imageUrl: TImages.disasterImage,
                  fit: BoxFit.cover,
                  applyImageRadius: true,
                ),
              ),
            ),
          ),

          // Appbar
          const TAppBar(
            showBackArrow: true,
            actions: [
              Icon(
                Iconsax.heart,
                color: TColors.white,
              )
            ],
          )
        ]),
      ),
    );
  }
}
