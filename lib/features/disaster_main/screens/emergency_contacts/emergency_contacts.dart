import 'package:flutter/material.dart';

import 'package:red_zone/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:red_zone/features/disaster_main/screens/emergency_contacts/widgets/emergency_contacts_tile.dart';
import '../../../../utils/constants/sizes.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TEmergencyContactsTile(),
                SizedBox(height: TSizes.spaceBtwSections),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
