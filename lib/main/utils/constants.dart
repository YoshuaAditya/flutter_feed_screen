import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

const home = "Home";
const ranking = "Ranking";
const notifications = "Notifications";
const me = "Me";

class BottomTabBarConstants {
  static final List<Widget> bottomTabIcons = [
    SvgPicture.asset(Assets.home),
    SvgPicture.asset(Assets.ranking),
    SvgPicture.asset(Assets.addGreen),
    SvgPicture.asset(Assets.notifications),
    SvgPicture.asset(Assets.profile),
  ];

  static final List<Widget> bottomTabIconSelected = [
    SvgPicture.asset(Assets.homeGreen),
    SvgPicture.asset(Assets.rankingGreen),
    SvgPicture.asset(Assets.closeGreen),
    SvgPicture.asset(Assets.notificationsGreen),
    SvgPicture.asset(Assets.profileGreen),
  ];

  static const List<Widget> bottomTabText = [
    Text(home, style: TextStyles.p12),
    Text(ranking, style: TextStyles.p12),
    Text(
      '',
      style: TextStyles.p0,
    ),
    Text(notifications, style: TextStyles.p12),
    Text(me, style: TextStyles.p12),
  ];

  static const List<Widget> bottomTabTextSelected = [
    Text(home, style: TextStyles.p12LightGreen),
    Text(ranking, style: TextStyles.p12LightGreen),
    Text(
      '',
      style: TextStyles.p0,
    ),
    Text(notifications, style: TextStyles.p12LightGreen),
    Text(me, style: TextStyles.p12LightGreen),
  ];

  static const List<double> iconHeights = [28.0, 28.0, 50.0, 28.0, 28.0];
  static const List<double> iconWidths = [28.0, 28.0, 52.0, 28.0, 28.0];
}
