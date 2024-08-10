import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.arrow_outward_sharp,
        color: Colors.grey,
        size: 20.0,
      ),
      label: const Row(
        children: [Text('Japan'), Icon(
          Icons.arrow_drop_down,
          size: 20.0,
        color: Colors.green)],
      ),
      onPressed: () {
        print('Button Pressed');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.black),
        ),
        fixedSize: const Size(double.infinity, 40),
      ),
    );
  }
}
