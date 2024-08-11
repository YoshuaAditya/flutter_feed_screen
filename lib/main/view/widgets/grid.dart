import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: InkResponse(
      enableFeedback: true,
      child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5)),

            child: ColoredBox(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.nearby),
                    const Text("Nearby", style: TextStyles.p10),
                  ],
                ),
            )),
      onTap: () => {
        debugPrint("object")
      }),
    );
  }
}
