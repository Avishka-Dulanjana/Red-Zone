import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/widgets/disaster_details_widgets/disaster_detail_image_slider.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/widgets/disaster_details_widgets/rating_share_widget.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';

class DisasterDetails extends StatelessWidget {
  const DisasterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Disaster Image Slider
            TDisasterImageSlider(),

            // Disaster Details
            Padding(
              padding: EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(children: [
                // Disaster Ratings and Share
                TRatingAndShare(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
