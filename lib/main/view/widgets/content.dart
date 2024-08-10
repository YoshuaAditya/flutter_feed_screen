import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/models/feed.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_feed_screen/main/view/widgets/collapsed_app_bar_content.dart';
import 'package:flutter_feed_screen/main/view/widgets/description_bar.dart';
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
  bool _isCollapsed = false;
  var top = 0.0;
  final double collapsedBarHeight = 60.0;
  final double expandedBarHeight = 400.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_updateCollapsedState);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalKey.currentState!.innerController.addListener(() {
        if (globalKey.currentState!.innerController.position.pixels ==
            globalKey.currentState!.innerController.position.maxScrollExtent) {
          setState(() {
            skipItems += 5;
            _isLoading = true;
            _getData();
          });
        }
      });
    });
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

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _updateCollapsedState() {
    _isCollapsed = _scrollController.hasClients &&
        _scrollController.offset > (expandedBarHeight - collapsedBarHeight);
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
      _getData();
    });
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
              child: NestedScrollView(
            key: globalKey,
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    expandedHeight: expandedBarHeight,
                    collapsedHeight: collapsedBarHeight,
                    floating: true,
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _isCollapsed ? 1 : 0,
                            child: const CollapsedAppBarContent(),
                          ),
                          background: _isCollapsed ? Container(
                            color: Colors.green,
                          ) : Image.network(
                            "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            fit: BoxFit.cover,
                          ));
                    })),
              ];
            },
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              separatorBuilder: (BuildContext context, int index) {
                return const ColoredBox(
                  color: Colors.green,
                  child: SizedBox(width: 50),
                );
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Feed",
                        textAlign: TextAlign.start,
                        style: TextStyles.feedTitle,
                      ),
                    ),
                  );
                }
                index -= 1;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleBar(
                          title: _list[index].title,
                          sku: "\$${_list[index].price.toString()}",
                          thumbnail: _list[index].thumbnail,
                        ),
                        DescriptionBar(
                            description: _list[index].description,
                            thumbnail: _list[index].thumbnail),
                        UserBar(
                            name: _list[index].title,
                            timestamp: _list[index].category),
                        SocialBar(
                            comments: _list[index].id,
                            likes: _list[index].stock),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _list.isEmpty ? 1 : _list.length + 1,
            ),
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
