import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/view/widgets/food_categories.dart';
import 'package:flutter_feed_screen/main/view/widgets/history_grid.dart';
import 'package:flutter_feed_screen/main/view/widgets/landmarks_grid.dart';
import 'package:flutter_feed_screen/main/view/widgets/location_button.dart';
import 'package:flutter_feed_screen/main/view/widgets/nearby_grid.dart';

class ExpandedAppBarContent extends StatelessWidget {
  const ExpandedAppBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
              crossAxisCount: 2,
              children: const <Widget>[
                NearbyGrid(),
                HistoryGrid(),
                LandmarksGrid(),
                FoodGrid(),
              ],
            );
  }
}
