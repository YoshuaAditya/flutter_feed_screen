import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class UserBar extends StatelessWidget {
  final String name;
  final String timestamp;

  const UserBar({
    super.key,
    required this.name,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              backgroundColor:
                  Color((math.Random().nextDouble() * 0xBBBBBB).toInt())
                      .withOpacity(1.0),
              foregroundColor: Colors.white,
              child: Text(name.substring(0, 1)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyles.primaryText),
                  Text(timestamp,style: TextStyles.tertiaryText),
                ],
              ),
            ),
          ]),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(Assets.bookmark)),
      ],
    );
  }
}
