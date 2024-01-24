import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/features/screens/password_configuration/reset_password.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../utils/constants/text_strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(TTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Text fields
            TextFormField(
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const ResetPasswordScreen()),
                  child: const Text(TTexts.submit),
                )),
          ],
        ),
      ),
    );
  }
}
