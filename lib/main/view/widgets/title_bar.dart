import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final String sku;
  final String thumbnail;

  const TitleBar({
    super.key,
    required this.title,
    required this.sku,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(children: [
            FadeInImage.assetNetwork(
              placeholder: Assets.restaurant,
              image: thumbnail,
              width: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: cWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.primaryText,
                  ),
                  Text(sku, style: TextStyles.tertiaryText),
                ],
              ),
            ),
          ]),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(icon: SvgPicture.asset(Assets.bookmark), onPressed: () => {
              debugPrint("Bookmark")
            },)),
      ],
    );
  }
}
