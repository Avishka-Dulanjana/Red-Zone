import 'package:flutter/material.dart';

import 'package:red_zone/common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../utils/constants/sizes.dart';
import 'Widgets/prediction_form.dart';
import 'Widgets/previous_disaster_tile.dart';

class PreviousDisasters extends StatelessWidget {
  const PreviousDisasters({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TPreviousDisasterTile(),
                  Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),

                    // Prediction form
                    child: PredictionForm(),
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
