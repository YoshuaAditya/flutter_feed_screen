import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class NearbyGrid extends StatelessWidget {

  const NearbyGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.nearby),
        const Text("Nearby", style: TextStyles.p10),
      ],
    );
  }
}
