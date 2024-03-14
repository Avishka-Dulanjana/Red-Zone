import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';

class AllPostsListScreen extends StatelessWidget {
  const AllPostsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('All Posts List'),
        showBackArrow: true,
      ),
    );
  }
}
