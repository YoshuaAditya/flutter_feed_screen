import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/utils_colors.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback voidCallback;
  const IconTextButton({
    super.key,
    required this.text,
    required this.icon,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: icon,
      label: Text(text),
      onPressed: () => {voidCallback()},
    );
  }
}
