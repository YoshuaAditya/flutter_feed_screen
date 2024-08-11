import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/models/feed.dart';
import 'package:flutter_feed_screen/main/utils/utils_colors.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_feed_screen/main/view/widgets/description_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/expanded_app_bar_content.dart';
import 'package:flutter_feed_screen/main/view/widgets/button/location_button.dart';
import 'package:flutter_feed_screen/main/view/widgets/social_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/title_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/user_bar.dart';
import 'package:http/http.dart' as http;

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  final List<Product> _list = [];
  final _scrollController = ScrollController();

  bool _isLoading = true;
  int skipItems = 0;
  int limitItems = 10;
  int listIndex = 0;
  var top = 0.0;
  final double collapsedBarHeight = 60.0;
  final double expandedBarHeight = 400.0;
  final double sliverPaddingBottom = 100.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadMore);
    _getData();
  }

  Feed? feedResponse;

  _getData() async {
    try {
      String url =
          "https://dummyjson.com/products?limit=$limitItems&skip=$skipItems";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        feedResponse = Feed.fromJson(json.decode(res.body));
        _list.addAll(feedResponse?.products as Iterable<Product>);
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        skipItems += 5;
        _isLoading = true;
        _getData();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
      _getData();
    });
  }

  List<Widget> _buildList() {
    List<Widget> listItems = [];

    listItems.add(const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "Feed",
          textAlign: TextAlign.start,
          style: TextStyles.feedTitle,
        ),
      ),
    ));
    for (int i = 0; i < _list.length; i++) {
      listItems.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleBar(
                title: _list[i].title,
                sku: "\$${_list[i].price.toString()}",
                thumbnail: _list[i].thumbnail,
              ),
              DescriptionBar(
                  description: _list[i].description,
                  thumbnail: _list[i].thumbnail),
              UserBar(name: _list[i].title, timestamp: _list[i].category),
              SocialBar(comments: _list[i].id, likes: _list[i].stock),
            ],
          ),
        ),
      ));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Container(
        color: const Color.fromARGB(255, 235, 235, 235),
        height: double.infinity,
        child: Column(children: [
          Flexible(
              child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverPersistentHeader(
                pinned: true,
                delegate: MyHeaderDelegate(),
              ),
              SliverList(delegate: SliverChildListDelegate(_buildList())),
            ],
          )),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ]),
      ),
    ));
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MyHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    const threshold = 0.5;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: progress > threshold ? 1 : progress,
            child: const ColoredBox(
              color: UtilsColors.mainGreen,
            ),
          ),
          AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            title: progress > threshold
                ? LocationButton(
                    isContrast: true,
                    text: 'Japan`',
                    voidCallback: () => {debugPrint("Location")})
                : const Text(""),
            flexibleSpace: progress > threshold
                ? const Text("")
                : const ExpandedAppBarContent(),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.white,
                onPressed: () => {debugPrint("Search")},
              ),
              IconButton(
                icon: const Icon(Icons.qr_code),
                color: Colors.white,
                onPressed: () => {debugPrint("QR")},
              ),
            ],
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
