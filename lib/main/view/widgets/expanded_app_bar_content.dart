import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/view/widgets/button/location_button.dart';
import 'package:flutter_feed_screen/main/view/widgets/food_categories_grid.dart';
import 'package:flutter_feed_screen/main/view/widgets/history_grid.dart';
import 'package:flutter_feed_screen/main/view/widgets/landmarks_grid.dart';
import 'package:flutter_feed_screen/main/view/widgets/nearby_grid.dart';

class ExpandedAppBarContent extends StatelessWidget {
  const ExpandedAppBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Center(
                    child: LocationButton(
                        isContrast: false,
                        text: 'Japan',
                        voidCallback: () => {debugPrint("Location")}),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                      height: 200,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            children: const [
                              NearbyGrid(
                                index: 0,
                                gridAxisCount: 2,
                              ),
                              HistoryGrid(
                                index: 1,
                                gridAxisCount: 2,
                              ),
                              LandmarksGrid(
                                index: 2,
                                gridAxisCount: 2,
                              ),
                              FoodGrid(
                                index: 3,
                                gridAxisCount: 2,
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          );
        
  }
}
