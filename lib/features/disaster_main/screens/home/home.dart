import 'package:flutter/material.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/home_appbar.bar.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/slider.dart';
import 'package:red_zone/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  SizedBox(height: 50),
                ],
              ),
            ),

            // Slider
            Padding(
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
