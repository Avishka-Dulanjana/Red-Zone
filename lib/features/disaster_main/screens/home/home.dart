import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/home_appbar.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/slider.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/disaster_main/screens/new_disaster/add_disaster.dart';
import 'package:red_zone/features/personalization/screens/profile/profile.dart';
import 'package:red_zone/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/device/device_utility.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Container(
                      width: TDeviceUtils.getScreenWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                        border: Border.all(color: TColors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Disaster',
                            style: TextStyle(
                              color: TColors.darkerGrey,
                              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.add_circle, color: TColors.darkerGrey),
                            onPressed: () => Get.to(() => const NewDisasterScreen()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // Slider
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TSlider(
                banners: [
                  TImages.banner2,
                  TImages.banner1,
                  TImages.banner3,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
