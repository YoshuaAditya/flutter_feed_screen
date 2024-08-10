import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/colors.dart';
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

