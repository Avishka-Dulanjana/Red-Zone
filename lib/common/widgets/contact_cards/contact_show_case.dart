import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../images/rounded_container.dart';
import 'emergecy_contact_card.dart';

class TContactShowcase extends StatelessWidget {
  const TContactShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TRoundedContainer(
      showBorder: true,
      boarderColor: TColors.darkGrey,
      backgroundColor: Colors.black,
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          TEmergencyContactCard(
            showBorder: false,
            contactDepartment: 'Police Department ',
            contactNo: '0717375582',
          ),
        ],
      ),
    );
  }
}
