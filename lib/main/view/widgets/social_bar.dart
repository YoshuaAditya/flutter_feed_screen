import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_svg/svg.dart';

class SocialBar extends StatelessWidget {
  final int comments;
  final int likes;

  const SocialBar({
    super.key,
    required this.comments,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SvgPicture.asset(Assets.share),
            const SizedBox(width: 10), 
            const Text("Share"),
          ]),
        ),
        Align(
          alignment: Alignment.centerRight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(width: 10), 
            SvgPicture.asset(Assets.comment),
            const SizedBox(width: 10), 
            Text("$comments"),
            const SizedBox(width: 10), 
            SvgPicture.asset(Assets.like),
            const SizedBox(width: 10), 
            Text("$likes"),
            const SizedBox(width: 10), 
          ]),
        ),
      ],
    );
  }
}
