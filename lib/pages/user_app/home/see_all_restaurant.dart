import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class SeeAllRestaurant extends StatelessWidget {
  const SeeAllRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: 'Profile Settings',
        actions: [Icon(Icons.search)],
      ),
    );
  }
}
