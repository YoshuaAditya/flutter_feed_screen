import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/utils_colors.dart';
import 'package:flutter_feed_screen/main/view/feed_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: UtilsColors.grey),
      ),
      home: const FeedScreen(),
    );
  }
}

//on flutter 3.24, web environment gives race error: https://github.com/flutter/flutter/issues/153222

