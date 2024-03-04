import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/appbar/tabbar.dart';
import 'package:red_zone/common/widgets/contact_cards/emergecy_contact_card.dart';
import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/common/widgets/layout/grid_layout.dart';
import 'package:red_zone/features/emergency_contacts/screens/widgets/category_tab.dart';

import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../common/widgets/contact_cards/contact_show_case.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Emergency Contacts', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: () {}, iconColor: dark ? TColors.white : TColors.dark),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 170, // Space between appbar and tab bar
                automaticallyImplyLeading: false,
                backgroundColor: dark ? TColors.black : TColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: TSizes.spaceBtwItems),
                      // Search Bar
                      TSearchContainer(text: "Emergency Contacts", showBackground: false, showBorder: true, padding: EdgeInsets.zero),
                      SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
                // Tabs
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Medical')),
                    Tab(child: Text('Fire Brigade')),
                    Tab(child: Text('Police Department')),
                    Tab(child: Text('Army')),
                    Tab(child: Text('Media Outlets')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
