import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/view/widgets/bottom_tab_bar.dart';

import '../utils/constants.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: const Column(),
        ),
        bottomNavigationBar: _bottomTabBar());
  }

  Widget _bottomTabBar() {
    return BottomTabBar(
      bottomNavIcons: BottomTabBarConstants.bottomTabIcons,
      bottomNavIconSelected: BottomTabBarConstants.bottomTabIconSelected,
      listText: BottomTabBarConstants.bottomTabText,
      listTextSelected: BottomTabBarConstants.bottomTabTextSelected,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      iconHeights: BottomTabBarConstants.iconHeights,
      iconWidths: BottomTabBarConstants.iconWidths,
    );
  }
}
