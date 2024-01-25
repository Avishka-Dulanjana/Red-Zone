import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/section_heading.dart';
import 'package:red_zone/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile.dart';
import '../../../../utils/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                  TAppBar(
                    title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white)),
                  ),
                  const TUserProfileTile(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            //Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// --Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSettingsMenuTile(icon: Iconsax.safe_home_copy, title: 'My Address', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.shopping_cart_copy, title: 'My Cart', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.bag_tick_2, title: 'My Orders', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.bank_copy, title: 'Bank Account', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.discount_shape_copy, title: 'My Coupons', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subtitle: 'Set shopping delivery address'),
                  const TSettingsMenuTile(icon: Iconsax.security_time_copy, title: 'Account Privacy', subtitle: 'Set shopping delivery address'),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSettingsMenuTile(icon: Iconsax.document_upload_copy, title: 'Load Data', subtitle: 'Upload data to your cloud firebase'),

                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geo Location',
                    subtitle: 'Set recommended location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Set recommended location',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set recommended location',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// - Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
