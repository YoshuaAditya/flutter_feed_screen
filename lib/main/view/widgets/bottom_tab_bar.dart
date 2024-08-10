import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  final List<Widget> bottomNavIcons;
  final List<Widget> bottomNavIconSelected;
  final List<Widget> listText;
  final List<Widget> listTextSelected;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final List<double> iconHeights;
  final List<double> iconWidths;

  const BottomTabBar({
    super.key,
    required this.bottomNavIcons,
    required this.bottomNavIconSelected,
    required this.listText,
    required this.listTextSelected,
    required this.onTap,
    required this.currentIndex,
    required this.iconHeights,
    required this.iconWidths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xaaaaaaaa), // Adjust color as needed
            width: 1.0, // Adjust thickness as needed
          ),
        ),
      ),
      child: AnimatedBottomNavigationBar.builder(
        height: 60,
        elevation: 0,
        itemCount: bottomNavIcons.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: iconHeights[index],
                width: iconHeights[index],
                child: isActive
                    ? bottomNavIconSelected[index]
                    : bottomNavIcons[index],
              ),
              const SizedBox(height: 0),
              isActive ? listTextSelected[index] : listText[index],
            ],
          );
        },
        activeIndex: currentIndex,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        notchMargin: 0,
        splashSpeedInMilliseconds: 300,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: onTap,
        splashColor: Colors.grey,
      ),
    );
  }
}
