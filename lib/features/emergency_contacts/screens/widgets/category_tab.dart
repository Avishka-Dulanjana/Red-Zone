import 'package:flutter/material.dart';

import '../../../../common/widgets/contact_cards/contact_show_case.dart';
import '../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
              TContactShowcase(),
            ],
          ),
        ),
      ],
    );
  }
}
