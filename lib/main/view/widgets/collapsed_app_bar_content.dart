import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/view/widgets/location_button.dart';
import 'package:flutter_svg/svg.dart';

class CollapsedAppBarContent extends StatelessWidget {
  const CollapsedAppBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const LocationButton(),
            const Spacer(),
            const SizedBox(
              height: 40,
            ),
            SvgPicture.asset(Assets.search),
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(Assets.qrCode),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }
}
