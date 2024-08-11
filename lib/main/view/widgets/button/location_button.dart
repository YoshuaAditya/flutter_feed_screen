import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/utils_colors.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';

class LocationButton extends StatelessWidget {
  final bool isContrast;
  final String text;
  final VoidCallback voidCallback;
  const LocationButton({
    super.key,
    required this.text,
    required this.isContrast,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    if (isContrast) {
      return TextButton.icon(
        icon: const Icon(
          Icons.arrow_outward_sharp,
          color: Colors.white,
          size: 20.0,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: TextStyles.contrastText),
            const Icon(Icons.arrow_drop_down, size: 20.0, color: Colors.white)
          ],
        ),
        onPressed: () =>{
          voidCallback()
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 149, 69),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: UtilsColors.mainGreen),
          ),
          fixedSize: const Size(double.infinity, 40),
        ),
      );
    } else {
      return ElevatedButton.icon(
        icon: const Icon(
          Icons.arrow_outward_sharp,
          color: Colors.grey,
          size: 20.0,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: TextStyles.blackText),
            const Icon(Icons.arrow_drop_down, size: 20.0, color: UtilsColors.mainGreen)
          ],
        ),
        onPressed: () =>{
          voidCallback()
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.white),
          ),
          fixedSize: const Size(double.infinity, 40),
        ),
      );
    }
  }
}
