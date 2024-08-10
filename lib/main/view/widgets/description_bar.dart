import 'package:flutter/material.dart';

class DescriptionBar extends StatelessWidget {
  final String description;
  final String thumbnail;

  const DescriptionBar({
    super.key,
    required this.description,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Text(description)),
        Image.network(
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          thumbnail,
          width: 100,
        ),
      ],
    );
  }
}
