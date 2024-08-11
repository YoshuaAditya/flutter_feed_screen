import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/view/widgets/button/icon_text_button';
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
          child: IconTextButton(
            voidCallback: () =>{
              debugPrint("Share")
            },
            icon: SvgPicture.asset(Assets.share),
            text: "Share",
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(width: 10),
            IconTextButton(
              voidCallback: () =>{
                debugPrint("Comment")
              },
              icon: SvgPicture.asset(Assets.comment),
              text: "$comments",
            ),
            const SizedBox(width: 10),
            IconTextButton(
              voidCallback: () =>{
                debugPrint("Like")
              },
              icon: SvgPicture.asset(Assets.like),
              text: "$likes",
            ),
            const SizedBox(width: 10),
          ]),
        ),
      ],
    );
  }
}
