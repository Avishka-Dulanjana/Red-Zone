import 'package:flutter/material.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/widgets/disaster_details_widgets/disaster_detail_image_slider.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/widgets/disaster_details_widgets/rating_share_widget.dart';

import '../../../../utils/constants/sizes.dart';

class DisasterDetails extends StatelessWidget {
  const DisasterDetails({super.key, required this.disaster});

  final DisasterModel disaster;

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
