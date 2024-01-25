import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/home_appbar.bar.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/text_strings.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
